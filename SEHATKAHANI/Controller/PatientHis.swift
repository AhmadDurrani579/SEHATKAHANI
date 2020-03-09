//
//  PatientHis.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PatientHis: UIViewController, UITableViewDelegate, UITableViewDataSource  {

  
    @IBOutlet weak var image: ImageSetting!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    let ap = UIApplication.shared.delegate as! AppDelegate

    
    var summary: PatientSummary?

    let clearView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        clearView.backgroundColor = UIColor.clear // Whatever color you like
        PatientHistoryCell.appearance().selectedBackgroundView = clearView
        let xview = UIViewX()
        xview.frame = CGRect(x: 20, y: 0, width: self.view.frame.width - 40, height: 44)
        xview.backgroundColor = #colorLiteral(red: 0.9769807269, green: 0.9769807269, blue: 0.9769807269, alpha: 1)
        xview.shadowOpacity = 1
        xview.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        xview.shadowRadius = 16
        clearView.addSubview(xview)
        

//
//        image.cornerRadius3()
        
        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.dataSource = self
//        tableView.delegate = self
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
        getAllPendingAppointment()
        // Do any additional setup after loading the view.
    }
    
    func getAllPendingAppointment() {
        let idOfPatient = ap.appointmentObj?.patientId?.patientKey
        
        let idofAppointmet = [ "id"        : idOfPatient
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Summary, serviceType: "Summary" , modelType: PatientSummary.self, success: { (response) in
            self.summary = (response as! PatientSummary)
            if self.summary?.result != nil {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                self.tableView.estimatedRowHeight = 100
                self.tableView.rowHeight = UITableViewAutomaticDimension

            } else {
                
            }
           
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Medical History"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (summary?.result?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PatientHistoryCell
        cell.title.text = self.summary?.result![indexPath.row].name
//        cell.title.text = "History Notes"
        
        
//        cell.backgroundView = clearView
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        
        let titleOfView =  self.summary?.result![indexPath.row].name
        
        if  titleOfView == "Allergy" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "medicalHistory") as! PatientSingleNote
            ap.selectView = 0
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Surgical History" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "medicalHistory") as! PatientSingleNote
            ap.selectView = 1
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Immunization" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ImmunicatinViewController") as! ImmunicatinViewController
            ap.selectView = 2
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Past Disease" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ImmunicatinViewController") as! ImmunicatinViewController
            ap.selectView = 3
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Family History" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ImmunicatinViewController") as! ImmunicatinViewController
            ap.selectView = 4
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Current Medication" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "medicalHistory") as! PatientSingleNote
            ap.selectView = 5
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Social Activity" {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PatientSingleNote") as! PatientSingleNote
            ap.selectView = 5
            navigationController?.pushViewController(newViewController, animated: true)
        } else if titleOfView == "Physical Activity"
            {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PatientSingleNote") as! PatientSingleNote
            ap.selectView = 5
            navigationController?.pushViewController(newViewController, animated: true)
        }
        

        
        
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func switchToViewController(viewController: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: viewController)
        navigationController?.pushViewController(newViewController, animated: true)
    }
}













