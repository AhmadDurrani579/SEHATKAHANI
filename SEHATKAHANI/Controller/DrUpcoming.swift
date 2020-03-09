//
//  DrUpcoming.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 01/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class DrUpcoming: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var lblTxtOfDetail: UILabel!
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reasonTextField: TextFieldView!
    @IBOutlet weak var feedButton: UIButton!
    var indexOfAppointmet: Int?

    @IBOutlet weak var tableView: UITableView!
    var array = ["","","","","","","",""]
    
    @IBOutlet var feedbackView: UIView!
    var pendingAppointment: GetPendingAppointment?

    override func viewDidLoad() {
        super.viewDidLoad()
//

        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts) // Load the image centered
//        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        reasonTextField.cornerRad1()
        reasonTextField.padding(value: 14)
        reasonTextField.delegate = self
        feedButton.cornerRad1()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        let nibName = UINib(nibName: "AppointmentsCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AppointmentsCell")
        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.dataSource = self
//        tableView.delegate = self
        getAllPendingAppointment()
        // Do any additional setup after loading the view.
    }
    
    func getAllPendingAppointment() {
        let idOfUser = APIManager.sharedInstance.getLoggedInUser()?.id
        var url: String!
        
        let idofAppointmet = [ "Id"        : idOfUser
            ] as [String : AnyObject]
        
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            url = GET_PendingAppointment
        }else {
            url = GET_PATINET_UPCOMMING_APPOINTMENTS
        }
        
        WebServiceManager.post(params: idofAppointmet , serviceName: url, serviceType: "Pending Appointment / Pateint upcoming appointments" , modelType: GetPendingAppointment.self, success: { (response) in
            self.pendingAppointment = (response as! GetPendingAppointment)
            
            if  self.pendingAppointment?.success == true {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                self.tableView.estimatedRowHeight = 100
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                
            }else {
            }
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Upcoming Appointment"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.pendingAppointment?.result?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsCell", for: indexPath) as! AppointmentsCell
        cell.closeHandler = {() -> Void in
            self.detailpopUpView(index: indexPath.row)
        }
        
        cell.cancelAppointment = {() -> Void in
            self.feedBackPopUpView(index: indexPath.row)
        }
        var firstName: String!
        var lastName: String!
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            firstName = self.pendingAppointment?.result![indexPath.row].patientId?.patientName?.first
            lastName = self.pendingAppointment?.result![indexPath.row].patientId?.patientName?.last
        }else {
            firstName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.first
            lastName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.last
            if let url = self.pendingAppointment?.result![indexPath.row].doctorID?.patientPhotos?.url{
                let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
                cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                    
                    print((1 / totalSize) * 100)
                }, completionHandler: nil)
            }

        }
        
        
        
        
        var startDate = self.pendingAppointment?.result![indexPath.row].appointmentTime
        var endDate = self.pendingAppointment?.result![indexPath.row].appointmentEndTime
        
        
        if let str1 = startDate {
            let str = str1
            let index = str.index(str.startIndex, offsetBy: 11)
            let startChar = str[index] // returns Character 'u'
            print(startChar)
            
            // 2
            // Get a character at X position (index) starting from the end of the string
            let endIndex = str.index(str.endIndex, offsetBy: -5) // Goes to the end of the string and back to characters
            let endChar = str[endIndex] // returns Character "p"
            print(endChar)
            
            // 3
            // Get the substring, starting from index and ending at endIndex
            let subString = str[(index ..< endIndex)]
            print(subString) // returns "u Ap"
            startDate = subString
        }
        if let str1 = endDate {
            let str = str1
            let index = str.index(str.startIndex, offsetBy: 11)
            let startChar = str[index] // returns Character 'u'
            print(startChar)
            
            // 2
            // Get a character at X position (index) starting from the end of the string
            let endIndex = str.index(str.endIndex, offsetBy: -5) // Goes to the end of the string and back to characters
            let endChar = str[endIndex] // returns Character "p"
            print(endChar)
            
            // 3
            // Get the substring, starting from index and ending at endIndex
            let subString = str[(index ..< endIndex)]
            print(subString) // returns "u Ap"
            endDate = subString
        }
        if let s = startDate , let e = endDate {
             cell.timeFromAndTo.text = "\(s) - \(e)"
        }
       
        
        if let url = self.pendingAppointment?.result![indexPath.row].patientId?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        cell.delegate = self
        cell.index = indexPath
        cell.drName.text = "\(firstName!) \(lastName!)"
        cell.timeSlot.text = self.pendingAppointment?.result![indexPath.row].appointmentDate
//        cell.timeFromAndTo.text  = "\(startDate!) \n \(endDate!)"
        
        //        cell.descriptionOfAppointment.text = self.pendingAppointment?.result![indexPath.row].descriptionofAppointment
        //        cell.delegate = self
        //        cell.index = indexPath
        //        cell.name.textColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        
        //        cell.drName.text = "Amman Ullah Khan"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("google.......")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func detailpopUpView(index: Int) {
        
        customView()
        print("Yhaoooo" , index)
        
    }
    
    func feedBackPopUpView(index: Int) {
        
        feedbackCustomView()
        print("Yhaoooo" , index)
        
    }
    
    func customView() {
        let width = view.frame.width / 1.3
        let x = view.frame.width - width
        detailView.frame = CGRect(x: x / 2, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
        detailView.layer.cornerRadius = 15
        view.addSubview(detailView)
        let appointmentKey  = self.pendingAppointment?.result![self.indexOfAppointmet!].descriptionofAppointment
        lblTxtOfDetail.text = appointmentKey
        closeButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height / 2.5
        }) { (true) in

        }
    }
    
    func feedbackCustomView() {
        let width = view.frame.width / 1.3
        let x = view.frame.width - width
        feedbackView.frame = CGRect(x: x / 2, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
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
            self.detailView.frame.origin.y = self.view.frame.height
            self.feedbackView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.detailView.removeFromSuperview()
            self.feedbackView.removeFromSuperview()
        }

    }
    
    
    @IBAction func feedbackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height
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
            self.closeButton.alpha = 0
        }) { (true) in
            self.feedbackView.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension DrUpcoming  : CancelUpcomingAppointment {
   
    func cancelUpcomingAppointment(cancel :  AppointmentsCell , indexPath : IndexPath) {
        indexOfAppointmet = indexPath.row
        
//        feedbackCustomView()

    }
    
    func appointmentDetailClick(cancel :  AppointmentsCell , indexPath : IndexPath)
    {
        indexOfAppointmet = indexPath.row

    }

}

