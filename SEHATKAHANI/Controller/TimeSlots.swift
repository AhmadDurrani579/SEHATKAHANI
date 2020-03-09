//
//  TimeSlots.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class TimeSlots: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectDate : String?
    var slotOfDoctor : GetAllDoctorSlot?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "")?.withAlignmentRectInsets(inserts)
        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        
        
        let nibName1 = UINib(nibName: "TimeSlotsCell", bundle: nil)
        tableView.register(nibName1, forCellReuseIdentifier: "TimeSlotsCell")

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        getAllSlot()
    }
    
    func getAllSlot() {
        let doctorID = APIManager.sharedInstance.getId()

        
        let idofAppointmet = [ "userId"        : doctorID ,
                                "date"         : selectDate
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETSLotsPerDay, serviceType: "Get SLot" , modelType: GetAllDoctorSlot.self, success: { (response) in
            self.slotOfDoctor = (response as! GetAllDoctorSlot)
            if  self.slotOfDoctor?.success == true {
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
        return (self.slotOfDoctor?.allSlot?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotsCell", for: indexPath) as! TimeSlotsCell
        cell.closeHandler = {()-> Void in
            self.inedx()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy 'at' h:mm:ss a zzzz"
        let startTime = self.slotOfDoctor?.allSlot![indexPath.row].timestart
        let endTime = self.slotOfDoctor?.allSlot![indexPath.row].timeend

        
        var calendar = Calendar.current

        let dateFormatter = DateFormatter()
        let startTimeResult = startTime
        let endTimeResult = endTime
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        let result = dateFormatter.date(from: startTimeResult!) // 2017-06-16 17:18:59 +0000
        let endTimeFormatter = dateFormatter.date(from: endTimeResult!) // 2017-06-16 17:18:59 +0000

        let timeFormat = DateFormatter()
        calendar.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        timeFormat.date(from: "HH-mm-ss")
        calendar.dateComponents(in:NSTimeZone(name: "UTC")! as TimeZone , from: result!)
        calendar.dateComponents(in:NSTimeZone(name: "UTC")! as TimeZone , from: endTimeFormatter!)

            let startHour = calendar.component(.hour , from: result!)
            let startMinute = calendar.component(.minute, from: result!)
            let startSec = calendar.component(.second , from: result!)
        
            let endHour = calendar.component(.hour , from: endTimeFormatter!)
            let endMinute = calendar.component(.minute, from: endTimeFormatter!)
            let endSec = calendar.component(.second , from: endTimeFormatter!)

        let fullStartTime = ("\(startHour):\(startMinute): \(startSec) ")
        let fullEndTime = ("\(endHour):\(endMinute): \(endSec) ")
        cell.timer.text = ("\(fullStartTime) - \(fullEndTime)")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func inedx() {
        print("yahoo")
    }
    @IBAction func addNewSlot(_ sender: Any) {
     switchToViewController(viewController: "addNewSlot")
        
    }
    
    func switchToViewController(viewController: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "addNewSlot") as! NewSlot
//            selectDate
        newViewController.selectDate = selectDate
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

}



























