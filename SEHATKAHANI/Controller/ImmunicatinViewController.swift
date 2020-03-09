//
//  ImmunicatinViewController.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ImmunicatinViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let ap = UIApplication.shared.delegate as! AppDelegate
    var getAllImmunizationList : GetImmunization?

    var getAllDiseaseList : GetPastDisease?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "ImmunizationCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ImmunizationCell")
        
        
        let pastDiseaseNib = UINib(nibName: "PastDiseaseCell", bundle: nil)
        tableView.register(pastDiseaseNib, forCellReuseIdentifier: "PastDiseaseCell")
        
        
        let familyNib = UINib(nibName: "FamilyHistoryCell", bundle: nil)
        tableView.register(familyNib, forCellReuseIdentifier: "FamilyHistoryCell")
        
        if ap.selectView == 2  {
            getAllImmunicationDisease()

        } else if ap.selectView == 3 {
            getAllPastDisease()
        }
        else if ap.selectView == 4 {
            getAllFamilyHistory()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllFamilyHistory() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Family, serviceType: "Consultant Detail" , modelType: GetPastDisease.self, success: { (response) in
            
            self.getAllDiseaseList = (response as! GetPastDisease)
            if self.getAllDiseaseList?.allDisease == nil {
                
            } else {
                if  self.getAllDiseaseList?.success == true {
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
    
    
    func getAllPastDisease() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_PastDisease, serviceType: "Consultant Detail" , modelType: GetPastDisease.self, success: { (response) in

            self.getAllDiseaseList = (response as! GetPastDisease)
            if self.getAllDiseaseList?.allDisease == nil {

            } else {
                if  self.getAllDiseaseList?.success == true {
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
    
    func getAllImmunicationDisease() {
        let patientId = ap.appointmentObj?.patientId?.patientKey
        
        
        let idofAppointmet = [ "id"        : patientId
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETImmunization, serviceType: "Consultant Detail" , modelType: GetImmunization.self, success: { (response) in
            
            self.getAllImmunizationList = (response as! GetImmunization)
            if self.getAllImmunizationList?.immunization == nil {
                
            } else {
                if  self.getAllImmunizationList?.success == true {
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
    
}
extension ImmunicatinViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ap.selectView == 2 {
            if self.getAllImmunizationList?.immunization == nil {
                return 0
            } else {
                return (self.getAllImmunizationList?.immunization?.count)!

            }
        } else if ap.selectView == 3 {
            
            if self.getAllDiseaseList?.allDisease == nil {
                return 0
            } else {
                return (self.getAllDiseaseList?.allDisease?.count)!

            }

        } else {
            if self.getAllDiseaseList?.allDisease == nil {
                return 0
            } else {
                return (self.getAllDiseaseList?.allDisease?.count)!
                
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ap.selectView == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImmunizationCell", for: indexPath) as! ImmunizationCell
//            cell.titleOfDiesease.text = self.getAllAlergy?.allergy![indexPath.row].Notes
            
             let booster = self.getAllImmunizationList?.immunization![indexPath.row].Booster
            if booster == true {
                cell.btnBooster .setTitle("YES" , for: .normal)
            } else {
                cell.btnBooster .setTitle("NO" , for: .normal)
            }
            cell.titleOfDiesease.text = self.getAllImmunizationList?.immunization![indexPath.row].Vaccination
            cell.lblBooster.text = self.getAllImmunizationList?.immunization![indexPath.row].Boostertype
            cell.lblNumberOfBooster.text = self.getAllImmunizationList?.immunization![indexPath.row].Boosterfrequency
            return cell
        }
        else if ap.selectView == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PastDiseaseCell", for: indexPath) as! PastDiseaseCell
            let booster = self.getAllDiseaseList?.allDisease![indexPath.row].Treatment
            if booster == true {
                cell.btnBooster .setTitle("YES" , for: .normal)
            } else {
                cell.btnBooster .setTitle("NO" , for: .normal)
            }
            cell.titleOfDiesease.text = self.getAllDiseaseList?.allDisease![indexPath.row].Disease
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyHistoryCell", for: indexPath) as! FamilyHistoryCell
            cell.titleOfDiesease.text = self.getAllDiseaseList?.allDisease![indexPath.row].Disease
            cell.relation.text = self.getAllDiseaseList?.allDisease![indexPath.row].Relation

            
            //            cell.titleOfDiesease.text = self.getAllAlergy?.allergy![indexPath.row].Notes
            return cell

        }
        
//        cell.lblTitleOfSymptom.text = "1000"
//        cell.lblNumberOfBooster.text = "2000"
//        cell.lblSymptom.text = self.getAllAlergy?.allergy![indexPath.row].Reaction
//        cell.lblDrugName.text = self.getAllAlergy?.allergy![indexPath.row].type

        
//        @IBOutlet var titleOfDiesease: UILabel!
//        @IBOutlet var lblBooster: UILabel!
//        @IBOutlet var lblNumberOfBooster: UILabel!

//        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ap.selectView == 2  {
            return 277

        } else if ap.selectView == 3 {
            return 138.0
        } else {
            return 130.0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
}

