
//  Upcoming.swift
//  Sehat Kahani

//  Created by M Zia Ur Rehman Ch. on 26/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.


import UIKit
import Kingfisher

class Upcoming: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popupView: UIView!
    
    var selectedIndexPath: IndexPath?
    var isExpended = false
    
    var oppintmentId : String!
    
    var selectedIndex: Int?
    
    var pendingOppintment: GetPendingAppointment?
    
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView = UIVisualEffectView()

    var array = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "UpcomingExpandableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "UpcomingExpandableCell")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    
        getPatientPendingOppointments()
        
        //""
        
        

//
//        // 4 & 5
//        // Get the substring starting from Index until the End of the String
//        let indexToEnd = str.substring(from: index)
//        // Get the substring starting frmo the Start of the String to the Index
//        let startToIndex = str.substring(to: index)
//        print(indexToEnd) // returns String "u Apps"
//        print(startToIndex) // returns String "Seem"
        
//        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Upcoming"
    }
    
    func didExpended(){
        self.isExpended = !isExpended
        self.tableView.reloadRows(at: [selectedIndexPath!], with: .automatic)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingOppintment?.result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingExpandableCell", for: indexPath) as! UpcomingExpandableCell
        
        
        

        let firstName = self.pendingOppintment?.result![indexPath.row].doctorID?.patientName?.first
        let lastName = self.pendingOppintment?.result![indexPath.row].doctorID?.patientName?.last
        cell.name.text  = "\(firstName!) \(lastName!)"
        cell.descriptionOfAppointment.text = self.pendingOppintment?.result![indexPath.row].descriptionofAppointment
        cell.drType.text = self.pendingOppintment?.result![indexPath.row].appointmentDate
        
        if let time = self.pendingOppintment?.result![indexPath.row].appointmentTime ,  let end = self.pendingOppintment?.result![indexPath.row].appointmentEndTime {
           
            let str = time
            let str2 = end
            
             1
            // Get a character at X position (index)
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



            
            
            let index2 = str2.characters.index(str2.startIndex, offsetBy: 11)
            let startChar2 = str2[index2] // returns Character 'u'
            print(startChar2)
            
            // 2
            // Get a character at X position (index) starting from the end of the string
            let endIndex2 = str2.characters.index(str2.endIndex, offsetBy: -5) // Goes to the end of the string and back to characters
            let endChar2 = str2[endIndex2] // returns Character "p"
            print(endChar2)
            
            // 3
            // Get the substring, starting from index and ending at endIndex
            let subString2 = str2[(index2 ..< endIndex2)]
            print(subString2) // returns "u Ap"

            
            cell.lblStartEndTime.text = "\(subString) - \(subString2)"
        }
      
        
        
        
        
        
        if let url = self.pendingOppintment?.result![indexPath.row].doctorID?.patientPhotos?.url {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in

                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        cell.closeHandler = {()-> Void in
            self.delete()
        }
//        cell.drType.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath  = indexPath
       self.oppintmentId =  self.pendingOppintment?.result![indexPath.row].timeslotId
        self.didExpended()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.isExpended && self.selectedIndexPath == indexPath {
            return 235
        }
            return 125
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete") { (action , indexPath ) -> Void in
            self.isEditing = false
            print("Rate button pressed")
        }

        return [rateAction]
    }
    
    @IBAction func yesButton(_ sender: Any) {
        
        if let index = self.selectedIndexPath?.row {
           yesDelete(index: index)
        }
        
       
    }
    @IBAction func noButton(_ sender: Any) {
        popupView.removeFromSuperview()
        blurEffectView.removeFromSuperview()
    }
    
    func yesDelete(index: Int)   {
        self.pendingOppintment?.result!.remove(at: index)
        cancelPatientPendingOppointments(oppintmentId: self.oppintmentId)
        tableView.reloadData()
        popupView.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        
    }
    
    func delete() {
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.6
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        let width = self.view.frame.width / 1.3
        popupView.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.height / 3)
        popupView.layer.cornerRadius = popupView.frame.height / 10
        popupView.center = self.tableView.center
        view.addSubview(popupView)

    }
    
    
    func getPatientPendingOppointments() {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [ "Id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_PATINET_UPCOMMING_APPOINTMENTS, serviceType: "Upcoming oppintment" , modelType: GetPendingAppointment.self, success: { (response) in
            self.pendingOppintment = (response as! GetPendingAppointment)
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()

            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    
    func cancelPatientPendingOppointments(oppintmentId: String) {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [ "userId"        : id,
                               "cancelreason"   : "",
                               "AppId"            : oppintmentId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_CancelAppointmentDoctor, serviceType: "Cancel oppintment" , modelType: GetPendingAppointment.self, success: { (response) in
            self.pendingOppintment = (response as! GetPendingAppointment)
     
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    
}































