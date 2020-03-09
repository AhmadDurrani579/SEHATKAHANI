//
//  Home.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 19/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import ImageIO
import Kingfisher

class Home: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var profileImage: ImageSetting!
    @IBOutlet weak var drButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var dismissbutton: UIButton!
    @IBOutlet weak var viewholder: UIView!
    @IBOutlet weak var lblTime: UILabel!

    
    @IBOutlet var sideBarMenu: UIView!
    @IBOutlet weak var userImage: ImageSetting!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var curveView: CurvedView!
    var gloableCurrentAppointment : SKAppointment!
    var responseTimer : Timer? = nil
    let requestedComponent: Set<Calendar.Component> = [ .hour, .minute, .second]
    let userCalendar = Calendar.current
    
    

      let array = [("graphic-banner-Artboard-14","Home"),("ios icons Artboard 9","Medical History"),("ios icons Artboard 10","Appointments"),("ios icons Artboard 11","Consultation History"),("ios icons Artboard 12","Favourite Doctor"),("ios icons Artboard 12","Forum"),("ios icons Artboard 12","Near by"),("logout","Log Out"),("ios icons Artboard 13","Settings")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SKSocketConnection.socketSharedConnection.connectSocket(userId: (APIManager.sharedInstance.getLoggedInUser()?.id!)! , sessionId: APIManager.sharedInstance.randomString(length: 8))

        
            sideBarMenu.frame = CGRect(x: -(self.view.frame.width / 1.4), y: 0, width: self.view.frame.width / 1.4, height: view.frame.height)
        
        viewholder.frame.origin.y = (UIApplication.shared.statusBarView?.frame.height)!
     
        
//        curveView.xView(value: 2.05)
        drButton.cornerRad()
        detailButton.cornerRad()
        
        userImage.imageBorderColor()
        userImage.layer.cornerRadius = self.userImage.frame.height / 2
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let fname = APIManager.sharedInstance.getLoggedInUser()?.name!["first"] {
            userName.text = "\(fname)"
        }

//        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "leftarrow")
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "leftarrow")
////        curveView.draw(curveView.frame)
        
        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts) // Load the image centered
        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        
       // social media login
       if APIManager.sharedInstance.geIsSocial() {

       }else {
        if  let ph = APIManager.sharedInstance.getLoggedInUser()?.userPhoto!["url"] {
                let photo = ph as! String
                print(photo)
                //        let url = ph as! String
                let url = photo
                let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
                self.profileImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                }, completionHandler: nil)
                self.userImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                }, completionHandler: nil)
            }
        }
        
//
     
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        profileImage.imageCorner(value: 2)
        self.navigationController?.isNavigationBarHidden = true
//        let when = DispatchTime.now() + 0.01
//        DispatchQueue.main.asyncAfter(deadline: when)
//        {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
            profileImage.layer.borderColor = #colorLiteral(red: 0.003573116381, green: 0.8284867406, blue: 0.5906156898, alpha: 1)
            profileImage.layer.borderWidth = 1
            
//        }

        getLatestDate()

    }
    @IBAction func dismissbutton(_ sender: Any) {
        closeSideMenu()
    }
    @IBAction func viewDetailBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "doctorUpcoming") as UIViewController
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let sta =  UIViewX()
        sta.frame = (UIApplication.shared.statusBarView?.bounds)!
        sta.firstColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.secondColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.horizontalGradient = false
        UIApplication.shared.keyWindow?.addSubview(sta)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    
    // Abu baker Code
    
    
    func getLatestDate() -> Void {
        
    let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/appointment/next_appointment_patient")
        guard let serviceUrl = URL(string: Url) else {
            return;
        }
        let parameterDictionary = [
            "id": APIManager.sharedInstance.getLoggedInUser()?.id
        ]
        
        APIManager.POST(url: Url, parameters:  parameterDictionary as [String : AnyObject]) { (responseString, json) in
            
            debugPrint(json?.string ?? "")
            
            
            if let jsonDict = json?.dictionaryObject {
                if let message = jsonDict["appointment"] as? NSDictionary{
                    if let userInfoData = message as? [String : AnyObject] {
                        if let appointment: SKAppointment = SKAppointment(JSON: userInfoData) {
                            self.gloableCurrentAppointment = appointment;
                            self.responseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                            return;
                        }
                    }
                }else  if let messageError = jsonDict["message"] as? String{
                    self.lblTime.text = messageError;
                }
            }
        //    APIManager.sharedInstance.customAlert(viewcontroller: self, message: "unable to call data")
        }
    }
    @objc func update() {
        // Something cool
        let appinmetnDate : Date  =   Singelton.sharedInstance.getDateFromServerString(serverDate: self.gloableCurrentAppointment.AppointmentTime!) as! Date
        debugPrint(self.gloableCurrentAppointment.AppointmentTime);

        let elapsed = appinmetnDate.timeIntervalSince(Date())
        self.lblTime.text = self.secondsToHoursMinutesSeconds(seconds: TimeInterval(elapsed))
        
        debugPrint(time);
        
    }
    func secondsToHoursMinutesSeconds (seconds : TimeInterval) -> (String) {
        
        
        var retStr = ""
        
        let hours = Int(seconds / 3600)
        let min = Int((seconds - Double(hours) * 3600) / 60)
        let sec = Int(seconds - Double(hours) * 3600 - Double(min) * 60)
        if hours > 0 {
            retStr = "\(hours) " + (hours == 1 ? "" : ":") + (min > 0 ? "  \(min) " + (min == 1 ? ":" : "") : "")
        } else if min > 0 {
            retStr = "\(min) " + (min == 1 ? "" : ":") + (sec > 0 ? "  \(sec) " + (sec == 1 ? "" : "") : "")
        } else if sec > 0 {
            retStr = "\(sec) " + (sec == 1 ? "" : "")
        } else {
            retStr = "Expired"
            self.resetTimer();
        }
        return retStr
        
    }
    
    func resetTimer() -> Void {
        if var aTimer = self.responseTimer {
            aTimer.invalidate()
        } else {
            //no timer to stop. Make sure you have a valid timer created
        }
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeSideMenu(){
 
        UIView.animate(withDuration: 0.3, animations: {
            
            self.sideBarMenu.frame.origin.x = -(self.view.frame.width / 1.4)
            self.dismissbutton.alpha = 0
        }) { (true) in
            
            self.sideBarMenu.removeFromSuperview()
        }
      
    }
    
    func openSideMenu(){
        view.addSubview(self.sideBarMenu)
            
        self.dismissbutton.alpha = 1
        self.userImage.frame.size.height = self.userImage.frame.width
        
        UIView.animate(withDuration: 0.3) {
            self.sideBarMenu.frame.origin.x = 0
            self.userImage.frame.size.height = self.userImage.frame.width
        }
    }
    
    @IBAction func sideBarMenu(_ sender: Any) {
        openSideMenu()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        cell.sidemenuTitle.text = array[indexPath.row].1
        cell.sidemenuImage.image = UIImage(named: array[indexPath.row].0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if indexPath.row == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SkMedicaclHistory") 
            navigationController?.pushViewController(newViewController, animated: true)
        }else if indexPath.row == 2 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "doctorUpcoming") as UIViewController
            navigationController?.pushViewController(newViewController, animated: true)
            //            switchToViewController(viewController: "upcomingAppointment")
            
        }else if indexPath.row == 3 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "abc") as UIViewController
            navigationController?.pushViewController(newViewController, animated: true)
            //            self.present(newViewController, animated: true, completion: nil)
            
        }  else if indexPath.row == 4 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "favouriteDoctor") as UIViewController
            navigationController?.pushViewController(newViewController, animated: true)
            //            self.present(newViewController, animated: true, completion: nil)
            
        }  else if indexPath.row == 5 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "forumList") as UIViewController
            navigationController?.pushViewController(newViewController, animated: true)
            //            self.present(newViewController, animated: true, completion: nil)
            
        } else if indexPath.row == 6 {


                        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKGoogleShowViewController")
           
                    navigationController?.pushViewController(newViewController, animated: true)
                    //self.present(navcontrollerGoogle, animated: true, completion: nil)

        }else if indexPath.row == 7 {
            
            APIManager.sharedInstance.resetLoggedInUser();
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "main") as UIViewController
//                logoutRequest()
          
                self.present(newViewController, animated: true)
//            
//                GIDSignIn.sharedInstance().signOut()
//                FBSDKLoginManager().logOut()
            
            
        }
        else  if indexPath.row == 8 {
            //            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            //            let newViewController = storyBoard.instantiateViewController(withIdentifier: "settings")
            //            navigationController?.pushViewController(newViewController, animated: true)
            //            self.present(newViewController, animated: true, completion: nil)
            switchToViewController(viewController: "settings")
        }
    }
    
    func switchToViewController(viewController: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: viewController)
        navigationController?.pushViewController(newViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    func logoutRequest() {
//
//        let jsonUrlString = APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/signout"
//
//        APIManager.GET(url: jsonUrlString, parameters: <#[String : AnyObject]#>) { (response, json) in
//
//
//            if let resposneStr = response {
//
//                debugPrint(resposneStr)
//
//            }else {
//
//            }
//        }
//
//    }
//
    
}



extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


























