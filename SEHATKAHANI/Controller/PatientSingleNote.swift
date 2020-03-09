//
//  PatientSingleNote.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PatientSingleNote: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var headerImage: ImageSetting!
    var selectViewController : Int?
    
    var getAllAlergy : GetAllergy?
    var getMedicine : GetPastDisease?

    
    
    let ap = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    
    let array = [("Specialities",["GENERAL PHYSICIAN","MAGICIAN","COOK"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"])]
    
    var sections = [Paory(name: "Aspirine", list: ["STRING"], expanded: true),Paory(name: "Aspirine", list: ["STRING"], expanded: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.topItem?.title = "Medical History"
        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.dataSource = self
//        tableView.delegate = self
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
//        headerImage.cornerRadius3()
        
        
        let nibName = UINib(nibName: "PatientSingleNoteCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "PatientSingleNoteCell")
        
        if ap.selectView == 0 {
            getAllAlergyData()

        } else if ap.selectView == 1 {
            getAllSurgicalHistory()

        } else if ap.selectView == 5 {
            getMedication()
            
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func getAllAlergyData() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Treatment, serviceType: "Consultant Detail" , modelType: GetAllergy.self, success: { (response) in
            
            self.getAllAlergy = (response as! GetAllergy)
            if self.getAllAlergy?.allergy == nil {
                
            } else {
                if  self.getAllAlergy?.success == true {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.tableView.estimatedRowHeight = 100
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    
                    
                }else {
                }
            }
           
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    
    func getAllSurgicalHistory() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Treatment, serviceType: "Consultant Detail" , modelType: GetAllergy.self, success: { (response) in
            self.getAllAlergy = (response as! GetAllergy)
            if  self.getAllAlergy?.success == true {
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
    
    
    func getMedication() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Medication, serviceType: "Consultant Detail" , modelType: GetPastDisease.self, success: { (response) in
            self.getMedicine = (response as! GetPastDisease)
            if  self.getMedicine?.success == true {
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
        if ap.selectView == 0 {
            if  self.getAllAlergy?.allergy == nil   {
                return 0
                
            } else {
                return (self.getAllAlergy?.treatment?.count)!
                
            }
        } else if ap.selectView == 1 {
            if  self.getAllAlergy?.allergy == nil   {
                return 0
                
            } else {
                return (self.getAllAlergy?.allergy?.count)!
                
            }
        } else {
            if  self.getMedicine?.allDisease == nil   {
                return 0
                
            } else {
                return (self.getMedicine?.allDisease?.count)!
                
            }
        }
       
//        return (getAllAlergy?.allergy?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientSingleNoteCell", for: indexPath) as! PatientSingleNoteCell
        if ap.selectView == 1{
            cell.lblTreatment.text = self.getAllAlergy?.allergy![indexPath.row].Notes
            cell.lblTitleOfSymptom.text = "Symptoms"
            cell.lblTreatmentTitle.text = "Treatment"
            cell.lblSymptom.text = self.getAllAlergy?.allergy![indexPath.row].Reaction
            cell.lblDrugName.text = self.getAllAlergy?.allergy![indexPath.row].type
            
        } else if ap.selectView == 2  {
            
            cell.lblDrugName.text = self.getAllAlergy?.allergy![indexPath.row].type
            cell.lblTitleOfSymptom.text = "Reason"
            cell.lblSymptom.text = self.getAllAlergy?.allergy![indexPath.row].reason
            cell.lblTreatmentTitle.text = "Date"
            cell.lblTreatment.text = self.getAllAlergy?.allergy![indexPath.row].dateOfSurger

        } else if ap.selectView == 5 {
            cell.lblDrugName.text = self.getMedicine?.allDisease![indexPath.row].Name
            cell.lblTitleOfSymptom.text = "Quantity"
            cell.lblSymptom.text = self.getMedicine?.allDisease![indexPath.row].Dosage
            cell.lblTreatmentTitle.text = "Comment"
            cell.lblTreatment.text = self.getMedicine?.allDisease![indexPath.row].Comments

        } else if ap.selectView == 0 {
            cell.lblDrugName.text = self.getAllAlergy?.treatment![indexPath.row].type
            cell.lblTitleOfSymptom.text = "Symptoms"
            cell.lblSymptom.text = self.getAllAlergy?.treatment![indexPath.row].Reaction
            cell.lblTreatmentTitle.text = "Treatment"
            cell.lblTreatment.text = self.getAllAlergy?.treatment![indexPath.row].dateOfSurger
            
        }
       
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 153
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
   
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = ExpandableHeaderView()
//        header.customInit(title: sections[section].name, section: section, delegate: self)
//        header.backgroundView?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//        return header
//
//    }
    
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //
    //        if tableView == tableView {
    //            cell.alpha = 0
    //            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 250, 0)
    //            cell.layer.transform = transform
    //            UIView.animate(withDuration: 0.7) {
    //
    //                cell.alpha = 1
    //                cell.layer.transform = CATransform3DIdentity
    //            }
    //        }
    //    }
    
 
    
    //MARK : - Confirming header view protocol.
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
        //        sections[section].expanded = !sections[section].expanded
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        //        for i in 0..<sections[section].subCategories.count {
        for i in 0..<sections[section].list.count {
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }

}
