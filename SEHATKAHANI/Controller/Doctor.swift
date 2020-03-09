//
//  Doctor.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 29/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class Doctor: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var lblAppointment: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var headerView: CurvedView!
    @IBOutlet weak var viewDetailButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var reasonTextField: TextFieldView!
    @IBOutlet weak var feedButton: UIButton!
    
    @IBOutlet var feedbackView: UIView!
    
    @IBOutlet var sideBarMenu: UIView!
    @IBOutlet weak var userImage: ImageSetting!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var countDownLbl: UILabel!
    
    @IBOutlet weak var SideMenutableView: UITableView!
    var indexOfAppointmet: Int?
    var indexOfAppointmetOfDetail: Int?
    let ap = UIApplication.shared.delegate as! AppDelegate

    
    var dismissButton:UIButton = UIButton()
    var pendingAppointment: GetPendingAppointment?
    var nextPendingAppointment: GetPendingAppointment?
    
    
    var array = ["","","","","","","",""]
    var selectedIndexPath: IndexPath?
    var isExpended = false
    
    var selectedIndex: Int?
    
    var date = ""
    var stime = ""
    var timer =  Timer()
    
  let menuArray = [("graphic-banner-Artboard-14","Home"),("ios icons Artboard 9","My Profile"),("ios icons Artboard 10","Appointments"),("ios icons Artboard 11","Time Slots"),("ios icons Artboard 12","Consultation History"),("logout","Log Out"),("ios icons Artboard 13","Settings")]
    
  
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    let userCalendar = Calendar.current
    
    let requestedComponent: Set<Calendar.Component> = [.day,.hour ,.minute,.second]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        if let fname = APIManager.sharedInstance.getLoggedInUser()?.name!["first"] {
            userName.text = "\(fname)"
        }
        
        
        if APIManager.sharedInstance.geIsSocial() {
            
        }else {
            if  let ph = APIManager.sharedInstance.getLoggedInUser()?.userPhoto!["url"] {
                let photo = ph as! String
                print(photo)
                //        let url = ph as! String
                let url = photo
                let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
                self.userImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                }, completionHandler: nil)
                self.userImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                }, completionHandler: nil)
            }
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        sideBarMenu.frame = CGRect(x: -(self.view.frame.width / 1.4), y: (UIApplication.shared.statusBarView?.frame.height)!, width: self.view.frame.width / 1.4, height: (UIApplication.shared.keyWindow?.frame.height)! - (UIApplication.shared.statusBarView?.frame.height)!)
        
        dismissButton.frame = CGRect(x: 0, y:(UIApplication.shared.statusBarView?.frame.height)!, width: self.view.frame.width, height: (UIApplication.shared.keyWindow?.frame.height)! - (UIApplication.shared.statusBarView?.frame.height)!)
        dismissButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5004716981)
        
        dismissButton.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        userImage.imageBorderColor()
        userImage.layer.cornerRadius = self.userImage.frame.height / 2

        reasonTextField.cornerRad1()
        reasonTextField.padding(value: 14)
        reasonTextField.delegate = self
        feedButton.cornerRad1()
        
       
        viewDetailButton.layer.cornerRadius = viewDetailButton.frame.height / 1.9

        let nibName = UINib(nibName: "UpcomingExpandableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "UpcomingExpandableCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.popForConsultantPatient(_:)), name: NSNotification.Name(rawValue: "Consultation_Doctor"), object: nil)

        getAllPendingAppointment()
        // Do any additional setup after loading the view.
        getNextAppointmentDoctor()
        
      
    }
    
    
    
    func printTime()
    {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       
        let startTime = Date()
        let endTime = dateFormatter.date(from: "\(self.date) \(self.stime):00")
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime, to: endTime!)
        countDownLbl.text =  "\(timeDifference.day!) : \(timeDifference.hour!) : \(timeDifference.minute!) : \(timeDifference.second!) "
        if timeDifference.day! <= 0 && timeDifference.hour! <= 0 && timeDifference.minute! <= 0 && timeDifference.second! <= 0 {
            self.timer.invalidate() // stop timer
            countDownLbl.text =  " 0 : 0 : 0 : 0"
        }

    }
    func popForConsultantPatient(_ notification: NSNotification) {
        
        let uiAlert = UIAlertController(title: "Consultation Request", message: ap.messageOfConsult , preferredStyle: UIAlertControllerStyle.alert)
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
//            func consultPatient(patientID : String , doctorID : String ,consultationID : String , message : String ) -> Void {
//                self.socket.emit("consult patient", patientID,doctorID , consultationID , message)
//            }

            

            SKSocketConnection.socketSharedConnection.consultPatient(patientID: self.ap.doctorConsultPatiendID! , doctorID: APIManager.sharedInstance.getId(), consultationID: self.ap.consultationIdOfDoctor!, message: "Request Accepted")
            
            self.ap.isConsultantDoctor = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKChatVC") as? SKChatVC
            self.navigationController?.pushViewController(newViewController!, animated: true)
            

        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Click of cancel button")
            SKSocketConnection.socketSharedConnection.reject_instant_consultation(patientID: self.ap.doctorConsultPatiendID!, message: "")
            
        }))
        
        SKSocketConnection.socketSharedConnection.missedConsultationListner(doctorID: APIManager.sharedInstance.getId(), consultationID: self.ap.consultationIdOfDoctor!) { (data, sata) in
           uiAlert.dismiss(animated: true, completion: nil)
        }
        
        
        self.present(uiAlert, animated: true, completion: nil)

        
//        APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Check")
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//            switch action.style{
//            case .default:
//                print("default")
//
//            case .cancel:
//                print("cancel")
//
//            case .destructive:
//                print("destructive")
//
//
//            }}))
//
//        self.present(alert, animated: true, completion: nil)
  

    }


    override func viewDidAppear(_ animated: Bool) {
        let sta =  UIViewX()
        sta.frame = (UIApplication.shared.statusBarView?.bounds)!
        sta.firstColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.secondColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.horizontalGradient = false
        UIApplication.shared.keyWindow?.addSubview(sta)
        UIApplication.shared.statusBarStyle = .lightContent
        
        SKSocketConnection.socketSharedConnection.connectSocket(userId: (APIManager.sharedInstance.getLoggedInUser()?.id)!, sessionId: APIManager.sharedInstance.randomString(length: 8))
        SKSocketConnection.socketSharedConnection.addActiveUsers(userId: (APIManager.sharedInstance.getLoggedInUser()?.id)!)
        
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
      
        
        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "")?.withAlignmentRectInsets(inserts)
        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        
        //        self.navigationController?.navigationBar.shadowImage = imgBackArrow

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
     
    }

    func getAllPendingAppointment() {
        let idOfUser = APIManager.sharedInstance.getId()
        
        let idofAppointmet = [ "Id"        : idOfUser
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_PendingAppointment, serviceType: "Pending Appointment" , modelType: GetPendingAppointment.self, success: { (response) in
            self.pendingAppointment = (response as! GetPendingAppointment)
            SKSocketConnection.socketSharedConnection.addActiveUsers(userId: APIManager.sharedInstance.getId())

            if self.pendingAppointment?.custom_response == nil {
                
            } else {
                if  self.pendingAppointment?.success == true {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.tableView.estimatedRowHeight = 100
                    self.tableView.rowHeight = UITableViewAutomaticDimension

            }else {
                }
                
            }
            let element  = self.pendingAppointment?.custom_response?.count ?? 0
            if (element > 0){
                self.lblAppointment.isHidden = true;
            }else{
                self.lblAppointment.isHidden = false;
            }

        }, fail: { (error) in

        }, showHUD: true)
        
        
    }

    func getNextAppointmentDoctor() {
        let idOfUser = APIManager.sharedInstance.getId()
        
        let idofAppointmet = [ "id"        : idOfUser
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_NEXT_APPOINTMENT_DOCTOR, serviceType: "Next Appointment" , modelType: GetPendingAppointment.self, success: { (response) in
            self.nextPendingAppointment = (response as! GetPendingAppointment)
            
            if self.nextPendingAppointment?.customResponseObject == nil {
                if  self.nextPendingAppointment?.success == true {
//                    if let startTime = self.nextPendingAppointment?.customResponseObject?.start_time , let date = self.nextPendingAppointment?.customResponseObject?.date_of {
//                        self.stime = startTime
//                        self.date = date
//                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.printTime), userInfo: nil, repeats: true)
//                        self.timer.fire()
//                    }
                }else {
       guard let text = self.nextPendingAppointment?.message, !text.isEmpty else {
                        self.countDownLbl.text = "No appointment"
                        return
                    }
                    self.countDownLbl.text =  self.nextPendingAppointment?.message

                }


          
            } else {
                if  self.nextPendingAppointment?.success == true {
                    if let startTime = self.nextPendingAppointment?.customResponseObject?.start_time , let date = self.nextPendingAppointment?.customResponseObject?.date_of {
                        self.stime = startTime
                        self.date = date
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.printTime), userInfo: nil, repeats: true)
                        self.timer.fire()
                    }
                }else {


                    guard let text = self.nextPendingAppointment?.message, !text.isEmpty else {
                         self.countDownLbl.text = "No appointment"
                        return
                    }
                      self.countDownLbl.text =  self.nextPendingAppointment?.message



                }
            }
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
        }, showHUD: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func btnAction() {
        closeSideMenu()
    }
    
    
    func closeSideMenu(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.sideBarMenu.frame.origin.x = -(self.view.frame.width / 1.4)
            self.dismissButton.alpha = 0
        }) { (true) in
            self.sideBarMenu.removeFromSuperview()
            self.dismissButton.removeFromSuperview()
        }
        
    }
    
    func openSideMenu(){
        UIApplication.shared.keyWindow?.addSubview(self.dismissButton)
        UIApplication.shared.keyWindow?.addSubview(self.sideBarMenu)
        self.dismissButton.alpha = 1
        self.userImage.frame.size.height = self.userImage.frame.width
        
        UIView.animate(withDuration: 0.3) {
            self.sideBarMenu.frame.origin.x = 0
            self.userImage.frame.size.height = self.userImage.frame.width
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == SideMenutableView {
            return menuArray.count
        }else {
            return self.pendingAppointment?.custom_response?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == SideMenutableView {
         let side = SideMenutableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
            side.sidemenuTitle.text = menuArray[indexPath.row].1
            side.sidemenuImage.image = UIImage(named: menuArray[indexPath.row].0)
            return side
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingExpandableCell", for: indexPath) as! UpcomingExpandableCell
        cell.closeHandler = {()-> Void in
//            self.feedbackCustomView()
        }
        cell.nameHandler = {()-> Void in
            self.jumpToView(index: indexPath)
        }
        //        cell.drType.text = "\(indexPath.row)"
        
        
//        drImage
        let firstName = self.pendingAppointment?.custom_response![indexPath.row].user?.first_name
        let lastName = self.pendingAppointment?.custom_response![indexPath.row].user?.last_name


        cell.name.text = "\(firstName!) \(lastName!)"
        cell.drType.text = self.pendingAppointment?.result![indexPath.row].appointmentDate
        cell.descriptionOfAppointment.text = self.pendingAppointment?.result![indexPath.row].descriptionofAppointment
        if let url = self.pendingAppointment?.result![indexPath.row].patientId?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        cell.delegate = self
        cell.index = indexPath
        cell.name.textColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        
        if let startTime = self.pendingAppointment?.custom_response![indexPath.row].appointment_start_time , let endTime = self.pendingAppointment?.custom_response![indexPath.row].appointment_start_time {
            cell.lblStartEndTime.text  = "\(startTime) | \(endTime)"
        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != SideMenutableView {
            self.selectedIndexPath  = indexPath
            self.didExpended()
        }
        if tableView == SideMenutableView {
            closeSideMenu()
              let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
            if indexPath.row == 1 {
//                switchToViewController(viewController: "drProfile")
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "drProfile") as UIViewController
                //        newViewController.appointmentObj = self.pendingAppointment?.result[indexOfAppointmet]
                        navigationController?.pushViewController(newViewController, animated: true)

            }
            if indexPath.row == 2 {
//                switchToViewController(viewController: "doctorUpcoming")
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "doctorUpcoming") as UIViewController
                //        newViewController.appointmentObj = self.pendingAppointment?.result[indexOfAppointmet]
                navigationController?.pushViewController(newViewController, animated: true)

                
            }
            if indexPath.row == 3 {
//                switchToViewController(viewController: "timeSlots")
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKDateSelectVC") as UIViewController
                navigationController?.pushViewController(newViewController, animated: true)

            }
           
            if indexPath.row == 4 {
                //                switchToViewController(viewController: "abc")
              
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "abc") as UIViewController
                //        newViewController.appointmentObj = self.pendingAppointment?.result[indexOfAppointmet]
                navigationController?.pushViewController(newViewController, animated: true)
                
            }
            if indexPath.row == 5 {
                
                APIManager.sharedInstance.resetLoggedInUser();
        
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "main") as UIViewController
                    self.present(newViewController, animated: true)
                 
                
            }
            
            
        } else {
            
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "patientDetails") as UIViewController
            
                    ap.appointmentObj = self.pendingAppointment?.result![indexPath.row]
                    navigationController?.pushViewController(newViewController, animated: true)

//            let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "patientDetails") as! UIViewController
////            newViewController.appointmentObj = self.pendingAppointment?.result![indexPath.row]
//            navigationController?.pushViewController(newViewController, animated: true)

        }
     
    }
    
    func jumpToView(index: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "patientDetails") 
//        newViewController.patientID = self.nextPendingAppointment?.customResponseObject?.consultation_id
        ap.appointmentObj = self.pendingAppointment?.result![index.row]
        navigationController?.pushViewController(newViewController, animated: true)
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView != SideMenutableView {
            
            return 235

//            if self.isExpended && self.selectedIndexPath == indexPath {
//                return 235
//            }
//            return 125
//        }else {
//            return 50
        } else {
                        return 50

        }
      
    }
    
    func didExpended(){
        self.isExpended = !isExpended
        self.tableView.reloadRows(at: [selectedIndexPath!], with: .automatic)
    }
   
    
    func feedbackCustomView() {
        let width = view.frame.width - 30
        feedbackView.frame = CGRect(x: 15, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
        feedbackView.layer.cornerRadius = 15
        view.addSubview(feedbackView)
        closeButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height / 2.5
        }) { (true) in
            
        }
    }
    
    
    
    @IBAction func dismissButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.feedbackView.removeFromSuperview()
        }
        
    }
    
    
    @IBAction func feedbackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
           
            let appointmentKey  = self.pendingAppointment?.result![self.indexOfAppointmet!].key

            let idofAppointmet = [  "AppId"        : appointmentKey ,
                                    "cancelreason" : self.reasonTextField.text!
                ] as [String : AnyObject]
            WebServiceManager.post(params: idofAppointmet , serviceName: GET_CancelAppointmentDoctor, serviceType: "Cancel Appointment" , modelType: GetPendingAppointment.self, success: { (response) in
                self.pendingAppointment = (response as! GetPendingAppointment)
                
                if  self.pendingAppointment?.success == true {
                    self.getAllPendingAppointment()
                    
                }else {
                }
                
                
            }, fail: { (error) in
                
            }, showHUD: true)
            
            
            
//
            
        }) { (true) in
            self.feedbackView.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func sideMenuButton(_ sender: Any) {
        openSideMenu()
    }
 
    @IBAction func viewDetailAction(_ sender: Any) {



    }

    func switchToViewController(viewController: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: viewController) as! PatientSingleConsultation
//        newViewController.appointmentObj = self.pendingAppointment?.result[indexOfAppointmet]
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
}

extension  Doctor : CancelAppointment {
    
    func cancelAppointmentOfDoctor(cancel :  UpcomingExpandableCell , indexPath : IndexPath)
    {
        indexOfAppointmet = indexPath.row
        
        feedbackCustomView()
        print("Hello")
    }
}
















