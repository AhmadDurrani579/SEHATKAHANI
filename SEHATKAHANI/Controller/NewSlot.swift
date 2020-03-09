//
//  NewSlot.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 05/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class NewSlot: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    @IBOutlet weak var s4: UIButton!
    @IBOutlet weak var s5: UIButton!
    @IBOutlet weak var s6: UIButton!
    @IBOutlet weak var s7: UIButton!
    
    @IBOutlet var timingView: UIViewX!
    
    @IBOutlet weak var timeIntervelField: UITextField!
    @IBOutlet weak var startTime: UIView!
    @IBOutlet weak var endTime: UIView!
//    @IBOutlet weak var radioButton: UIView!
    @IBOutlet weak var slots: UIView!
    @IBOutlet weak var numbers: UITextField!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var startTimeInterval : UILabel!
    @IBOutlet weak var endTimeInterval: UILabel!


    var onOff = false
    var Sat = false
    var Sund = false
    var Mond = false
    var Tue = false
    var Wed = false
    var Thur = false
    var Fri = false

    @IBOutlet weak var radioButton: UIViewX!
    var selectDate : String?
    var isStartOrEndTimeCheck : Bool?
    var isRadioButtonCheck : Bool?
    var slotOfDoctor : GetAllDoctorSlot?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        timeIntervelField.delegate = self
        numbers.delegate = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts)
        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        //        self.navigationController?.navigationBar.shadowImage = imgBackArrow
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        timingView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 180)
        
        
//        let date = Date()
//        let calendar = Calendar.current
        
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
        
        pickerView.addTarget(self, action: #selector(dateChanged(_:)
            ), for: .valueChanged)
 
        
    }
    
    func dateChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.timeZone = NSTimeZone(name: "GMT+5:00")! as TimeZone
        let localDate = dateFormatter.string(from: pickerView.date)

        if isStartOrEndTimeCheck == true {
            startTimeInterval.text = localDate

        } else {
            endTimeInterval.text = localDate

        }
    }
    @IBAction func btnAddSlot(_ sender: UIButton) {
        
            let doctorID = APIManager.sharedInstance.getId()
            
            
            let idofAppointmet = [ "id"                : ("\(doctorID)") ,
                                   "interval"          : timeIntervelField.text! ,
                                   "starttime"         : startTimeInterval.text! ,
                                   "endtime"           : endTimeInterval.text! ,
                                   "day"               : selectDate! ,
                                   "weeks"             : numbers.text! ,
                                    "repeat"           : (onOff) ,
                                    "mon"              : (Mond) ,
                                    "tue"              : (Tue) ,
                                    "wed"              : (Wed) ,
                                    "thu"              : (Thur) ,
                                    "fri"              : (Fri) ,
                                    "sat"              : (Sat) ,
                                    "sun"              : (Sund) ,

                ] as [String : AnyObject]
            WebServiceManager.post(params: idofAppointmet , serviceName: ADDNewSLot, serviceType: "Add New Slot" , modelType: GetAllDoctorSlot.self, success: { (response) in
                self.slotOfDoctor = (response as! GetAllDoctorSlot)
                if  self.slotOfDoctor?.success == true {
//                    self.tableView.delegate = self
//                    self.tableView.dataSource = self
//                    self.tableView.reloadData()
//                    self.tableView.estimatedRowHeight = 100
//                    self.tableView.rowHeight = UITableViewAutomaticDimension
//
//
                }else {
                }
                
                
            }, fail: { (error) in
                
            }, showHUD: true)
            
            
    

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        startTime.layer.cornerRadius = startTime.frame.height / 2
        startTime.layer.borderWidth = 1
        startTime.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        timeIntervelField.textcor()
        
        endTime.layer.cornerRadius = startTime.frame.height / 2
        endTime.layer.borderWidth = 1
        endTime.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        slots.layer.cornerRadius = startTime.frame.height / 2
        slots.layer.borderWidth = 1
        slots.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        
        numbers.textcor()
        timeIntervelField.padding(value: 18)
        numbers.padding(value: 18)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onOffButton(_ sender: Any) {
        if !onOff {
            
            radioButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            UIView.animate(withDuration: 0.2, animations: {
                self.slots.alpha = 0
                self.numbers.alpha = 0
            })
            onOff = true
            
        }else {
            radioButton.backgroundColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
            UIView.animate(withDuration: 0.2, animations: {
                self.slots.alpha = 1
                self.numbers.alpha = 1
            })
            onOff = false            
        }
        
    }
    
    @IBAction func slot1(_ sender: Any) {
        Sat = true
        myButtonTapped(myButton: s1)
    }
    @IBAction func slot2(_ sender: Any) {
        Sund = true

        myButtonTapped(myButton: s2)
    }
    @IBAction func slot3(_ sender: Any) {
        Mond = true
        myButtonTapped(myButton: s3)
    }
    @IBAction func slot4(_ sender: Any) {
        Tue = true

        myButtonTapped(myButton: s4)
    }
    @IBAction func slot5(_ sender: Any) {
        Wed = true
        myButtonTapped(myButton: s5)
    }
    @IBAction func slot6(_ sender: Any) {
        Thur = true

        myButtonTapped(myButton: s6)
    }
    @IBAction func slot7(_ sender: Any) {
        Fri = true

        myButtonTapped(myButton: s7)
    }
    
    func myButtonTapped(myButton: UIButton){
        if myButton.isSelected == true {
            myButton.isSelected = false
            myButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            myButton.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
            
        }else {
            myButton.isSelected = true
            myButton.backgroundColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
            myButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
    }
    
    @IBAction func endTiming(_ sender: Any) {
        isStartOrEndTimeCheck = false

        self.view.addSubview(timingView)
        UIView.animate(withDuration: 0.3, animations: {
            self.timingView.frame.origin.y = self.view.frame.height - 180
        }) { (true) in
            
        }
    }
    @IBAction func starTiming(_ sender: Any) {
        isStartOrEndTimeCheck = true
        self.view.addSubview(timingView)
        UIView.animate(withDuration: 0.3, animations: {
            self.timingView.frame.origin.y = self.view.frame.height - 180
        }) { (true) in
            
        }
    }
    @IBAction func done(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.timingView.frame.origin.y = self.view.frame.height
        }) { (true) in
            self.timingView.removeFromSuperview()
        }
    }
    
    
    @IBAction func timePicker(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        // datePicker.backgroundColor = UIColor.blue
        
       print(datePicker.timeZone?.hashValue)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
}

























