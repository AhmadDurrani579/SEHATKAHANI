//
//  PatientHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 12/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher
class PatientHistory: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var pendingAppointment: GetPendingAppointment?

    var array = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "History", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryCell")

        getAllDoctorConsultnat()
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "History"
    }
    
    func getAllDoctorConsultnat() {
        let idOfUser = APIManager.sharedInstance.getLoggedInUser()?.id
        var url: String!
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            url = OtherConsultationPatient
        }else {
            url = GET_PATIENT_ALL_CONSULTATION_DET
        }
        
        let idofAppointmet = [ "Id"        : idOfUser
            ] as [String : AnyObject]
        
        WebServiceManager.post(params: idofAppointmet , serviceName: url, serviceType: "Other Consultant History/ patient consultation detail" , modelType: GetPendingAppointment.self, success: { (response) in
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pendingAppointment?.result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! History
        cell.closeHandler = {()-> Void in
//            self.detailpopUpViews()
        }
        let firstName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.first
        let lastName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.last

        cell.drName.text = "\(firstName!) \(lastName!)"
        
        if let url = self.pendingAppointment?.result![indexPath.row].doctorID?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
            }, completionHandler: nil)
        }
        
        var startDate = self.pendingAppointment?.result![indexPath.row].startTime
        var endDate = self.pendingAppointment?.result![indexPath.row].endTime
       
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
            cell.lblDate.text = "\(s)"
            cell.dateLbl.text = "\(e)"
        }
      
        
        
         cell.missedButtonLabel.setTitle(self.pendingAppointment?.result![indexPath.row].Status, for: .normal)
        
        if self.pendingAppointment?.result![indexPath.row].Status?.lowercased() == "attended" {
            cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "accepted"), for: .normal)
            cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 8.143645165e-05, green: 0.78256358, blue: 0.5573937863, alpha: 1), for: .normal)
        } else if self.pendingAppointment?.result![indexPath.row].Status?.lowercased() == "cancelled" {
            cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "canceled"), for: .normal)
            cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1), for: .normal)
        } else if self.pendingAppointment?.result![indexPath.row].Status?.lowercased() == "rejected" {
            cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "rejected"), for: .normal)
            cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1), for: .normal)
        } else {
            cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "missed"), for: .normal)
            cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1), for: .normal)
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    

 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
