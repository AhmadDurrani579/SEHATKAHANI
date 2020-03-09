//
//  DrHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 01/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher
class DrHistory: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    
    var pendingAppointment: GetPendingAppointment?
     

    var array = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName = UINib(nibName: "History", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "History"
        Getallappointmentdoctor()
    }
    
    override func viewWillLayoutSubviews() {
        testLabel.sizeToFit()
    }
    
    
    func Getallappointmentdoctor() {
        let idOfUser = APIManager.sharedInstance.getLoggedInUser()?.id!
        var url: String!
        
        let idofAppointmet = [ "Id"        : idOfUser
            ] as [String : AnyObject]
        
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            url = GETALLAppointmentDoctor
        }else {
            url = GET_PAINT_MISSED_APPOINTMENTS
        }
        
        
        WebServiceManager.post(params: idofAppointmet , serviceName: url, serviceType: "Pending Appointment / Patinet missed appointments" , modelType: GetPendingAppointment.self, success: { (response) in
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
            self.detailpopUpView(index: indexPath.row)
        }

        cell.drName.text = "Amman Ullah Khan"
        var firstName: String!
        var lastName: String!
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            firstName = self.pendingAppointment?.result![indexPath.row].patientId?.patientName?.first
            lastName = self.pendingAppointment?.result![indexPath.row].patientId?.patientName?.last
        }else {
            firstName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.first
            lastName = self.pendingAppointment?.result![indexPath.row].doctorID?.patientName?.last
            cell.missedButtonLabel.setTitle(self.pendingAppointment?.result![indexPath.row].Status, for: .normal)
            
            if self.pendingAppointment?.result![indexPath.row].Status?.lowercased() == "attended" {
                cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "accepted"), for: .normal)
                cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 8.143645165e-05, green: 0.78256358, blue: 0.5573937863, alpha: 1), for: .normal)
            } else if self.pendingAppointment?.result![indexPath.row].Status?.lowercased() == "cancelled" {
                cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "canceled"), for: .normal)
                cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1), for: .normal)
            } else {
                cell.missedButtonLabel.setImage(#imageLiteral(resourceName: "missed"), for: .normal)
                cell.missedButtonLabel.setTitleColor(#colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1), for: .normal)
            }
            
            if let url = self.pendingAppointment?.result![indexPath.row].doctorID?.patientPhotos?.url {
                let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
                cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                    
                    print((1 / totalSize) * 100)
                }, completionHandler: nil)
            }
        }
        
        
        
        var startDate = self.pendingAppointment?.result![indexPath.row].appointmentTime
        var endDate = self.pendingAppointment?.result![indexPath.row].appointmentEndTime
        
        
        if let str1 = endDate {
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
            cell.dateLbl.text = subString
        }
        
        
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
            cell.lblDate.text = "\(s) - \(e)"
        }
   
        
        
        
        
        cell.drName.text = "\(firstName!) \(lastName!)"
        
        if let url = self.pendingAppointment?.result![indexPath.row].patientId?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        
        //        @IBOutlet weak var drImage: UIImageView!
        //        @IBOutlet weak var drName: UILabel!
        //        @IBOutlet var lblDate: UILabel!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
    func detailpopUpView(index: Int) {
        
        customView()
        testLabel.text = self.pendingAppointment?.result![index].descriptionofAppointment
        print("Yhaoooo" , index)
        
    }
    
    func customView() {
        let width = view.frame.width / 1.3
        let x = view.frame.width - width
        detailView.frame = CGRect(x: x / 2, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
        detailView.layer.cornerRadius = 15
        view.addSubview(detailView)
        closeButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height / 2.5
        }) { (true) in
            
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.detailView.removeFromSuperview()
        }
        
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
