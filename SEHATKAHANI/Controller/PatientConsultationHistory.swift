//
//  PatientConsultationHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 12/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher
class PatientConsultationHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var pendingAppointment: GetPendingAppointment?
    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts) // Load the image centered
        //
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)

        let nibName = UINib(nibName: "ConsultationHistory", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ConsultationHistory")
        
        getAllDoctorConsultnat()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.isTranslucent = false
        }else {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    
    func getAllDoctorConsultnat() {
        let idOfUser = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [ "Id"        : idOfUser
            ] as [String : AnyObject]
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            self.url = ConsultationPatient
        }else {
            self.url = GET_PATIENT_ALL_CONSULTATION
            
        }
        
        WebServiceManager.post(params: idofAppointmet , serviceName: url, serviceType: "Pending Appointment/patinet consultation history" , modelType: GetPendingAppointment.self, success: { (response) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultationHistory", for: indexPath) as! ConsultationHistory
        cell.closeHandler = {() -> Void in
            if let id = self.pendingAppointment?.result![indexPath.row].key {
                self.detailView(idPatient: id)
            }
           
        }
//
//        cell.cancelAppointment = {() -> Void in
//            self.feedBackPopUpView(index: indexPath.row)
//        }
//
//        cell.drName.text = "Amman Ullah Khan"
        
        
        let firstName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.first
        let lastName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.last

        
        var startDate = self.pendingAppointment?.result![indexPath.row].startTime
        var endDate = self.pendingAppointment?.result![indexPath.row].endTime
        var date = self.pendingAppointment?.result![indexPath.row].Date
        
        
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
            cell.timeSlot.text = "\(s) - \(e)"
        
        }
        
        if let str1 = date {
            let str = str1
            let index = str.index(str.startIndex, offsetBy: 0)
            let startChar = str[index] // returns Character 'u'
            print(startChar)
            
            // 2
            // Get a character at X position (index) starting from the end of the string
            let endIndex = str.index(str.endIndex, offsetBy: -14) // Goes to the end of the string and back to characters
            let endChar = str[endIndex] // returns Character "p"
            print(endChar)
            
            // 3
            // Get the substring, starting from index and ending at endIndex
            let subString = str[(index ..< endIndex)]
            print(subString) // returns "u Ap"
            date = subString
        }
        
        cell.dateOfAppointment.text = date
        cell.drName.text = "\(firstName!) \(lastName!)"
        
        if let url = self.pendingAppointment?.result![indexPath.row].doctorID?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
  
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
    func detailView(idPatient: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "consultationHistory") as! PatientSingleConsultation
        newViewController.patientID = idPatient
        navigationController?.pushViewController(newViewController, animated: true)
    }

}













