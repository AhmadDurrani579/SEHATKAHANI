//
//  SKDateSelectVC.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Daysquare

class SKDateSelectVC: UIViewController {
  
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var calenderView: DAYCalendarView!
    var selectDate : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
       
        datePicker.addTarget(self, action: #selector(getter: self.datePicker), for: .valueChanged)
        calenderView.addTarget(self, action: #selector(self.calendarViewDidChange), for: .valueChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func calendarViewDidChange (_ sender : Any) {
        self.datePicker.date = self.calenderView.selectedDate
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let myStringafd = formatter.string(from: calenderView.selectedDate!)
        selectDate = myStringafd
        print("\(formatter.string(from: calenderView.selectedDate))")
//        timeSlots
        
        
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "timeSlots") as! TimeSlots
        newViewController.selectDate = selectDate
        navigationController?.pushViewController(newViewController, animated: true)

        
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    


    func datePickerDidChange(_ sender: Any) {
        self.calenderView.selectedDate = self.datePicker.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
