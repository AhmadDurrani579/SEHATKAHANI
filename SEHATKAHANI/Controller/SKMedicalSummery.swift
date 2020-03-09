//
//  SKMedicalSummery.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKMedicalSummery: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var patientAllergies: GetAllergy?
    var pastDisease: GetPastDisease?
    var immunization: GetImmunization?
    var type: Int!
    var name: String!
    
    var array = [String]()
    //     var patineHistory: GetPastDisease?
    
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "FT_Add"), for: .normal)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.tintColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(SKChatVC.precription), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        
        tableView.estimatedRowHeight = 130
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        
        //Allergies cell
        let pastDiseaseCel = UINib(nibName: "PatientSingleNoteCell", bundle: nil)
        tableView.register(pastDiseaseCel, forCellReuseIdentifier: "PatientSingleNoteCell")
      
        //Social and Physical History
        let SKPhysicalAndSocial = UINib(nibName: "SKPhysicalAndSocial", bundle: nil)
        tableView.register(SKPhysicalAndSocial, forCellReuseIdentifier: "SKPhysicalAndSocial")
        
        //Past Disease
        let nibName = UINib(nibName: "PastDiseaseCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "PastDiseaseCell")
        
     
        
        if  self.name == "allergy" ||  self.name == "surgical history" || self.name == "past disease" || self.name == "family history" || self.name == "current medication" || self.name == "physical activity" || self.name == "social activity" {
            getCurrentMedication()
        }else if self.name == "immunization"{
            let nibName = UINib(nibName: "ImmunizationCell", bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: "ImmunizationCell")
            getImmunization()
        }
        
    }
    
    func precription() {
        if self.name == "allergy" {
            print("yahoo....")
        } else if self.name == "past disease" {
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.name == "immunization"  {
             return self.immunization?.immunization?.count ?? 0
        }else {
            return self.patientAllergies?.treatment?.count ?? 0
        }
     
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.name == "allergy" ||  self.name == "surgical history" || self.name == "current medication" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientSingleNoteCell", for: indexPath)   as! PatientSingleNoteCell
            if self.name == "allergy" {
                cell.lblTitleOfSymptom.text = "Reaction"
                cell.lblTreatmentTitle.text = "Treatment"
                cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].type1
                cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].Reaction
                cell.lblTreatment.text = self.patientAllergies?.treatment![indexPath.row].Notes
            } else if self.name == "current medication" {
                cell.lblTitleOfSymptom.text = "Quantity"
                cell.lblTreatmentTitle.text = "Comment"
                cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].name
                cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].dosage
                cell.lblTreatment.text = self.patientAllergies?.treatment![indexPath.row].comments
            } else {
                cell.lblTitleOfSymptom.text = "Reason"
                cell.lblTreatmentTitle.text = "Surgery Date"
                cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].type
                cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].reason
                if let str1 =  self.patientAllergies?.treatment![indexPath.row].dateOfSurger {
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
                    cell.lblTreatment.text = subString
                }
            }
           cell.selectedBackgroundView?.backgroundColor = UIColor.clear
            return cell
            
            
        } else if self.name == "past disease" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PastDiseaseCell", for: indexPath)   as! PastDiseaseCell
            cell.titleOfDiesease.text = self.patientAllergies?.treatment![indexPath.row].disease
            if self.patientAllergies?.treatment![indexPath.row].Response == "Yes" {
                cell.btnBooster.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else {
                cell.btnBooster.tintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            }
            cell.btnBooster.setTitle(self.patientAllergies?.treatment![indexPath.row].Response, for: .normal)
             cell.selectedBackgroundView?.backgroundColor = UIColor.clear
            return cell
            
            
        } else if self.name == "immunization" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImmunizationCell", for: indexPath)   as! ImmunizationCell
            cell.lblBooster.text = self.immunization?.immunization![indexPath.row].Boostertype
            cell.lblNumberOfBooster.text =  self.immunization?.immunization![indexPath.row].Boosterfrequency
            cell.titleOfDiesease.text = self.immunization?.immunization![indexPath.row].Boostertype
            if self.immunization?.immunization![indexPath.row].Response == "Yes" {
                cell.btnBooster.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else {
                cell.btnBooster.tintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            }
             cell.selectedBackgroundView?.backgroundColor = UIColor.clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SKPhysicalAndSocial", for: indexPath)   as! SKPhysicalAndSocial
            //            if type == 1{
            
            if self.name == "physical activity" {
                cell.title.text = self.patientAllergies?.treatment![indexPath.row].name
                cell.subTitle.text = "Frequency"
                cell.comment.text = self.patientAllergies?.treatment![indexPath.row].Frequency
            }else  if self.name == "social activity" {
                cell.title.text = self.patientAllergies?.treatment![indexPath.row].type1
                cell.subTitle.text = "Frequency"
                cell.comment.text = self.patientAllergies?.treatment![indexPath.row].Frequency
            }else {
                cell.title.text = self.patientAllergies?.treatment![indexPath.row].disease
                cell.subTitle.text = "Family Relation"
                cell.comment.text = self.patientAllergies?.treatment![indexPath.row].relation
            }
            cell.selectedBackgroundView?.backgroundColor = UIColor.clear
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.name == "immunization" {
            return 265
        }
        return  150
    }
    
    
    
    
    
    
    
    
    func getPatientPastHis()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [  "id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_ALLERGIES_LIST, serviceType: "Get Allergies" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    
    
    
    func getCurrentMedication()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        var url: String!
        let idofAppointmet = [  "id"        : id
            ] as [String : AnyObject]
        
        if self.name == "allergy" {
            url = GET_ALLERGIES_LIST
        } else if self.name == "surgical history" {
            url = GET_Treatment
        } else if self.name == "past disease" {
            url = GET_PastDisease
        } else if self.name == "family history" {
            url = GET_Family
        } else if self.name == "current medication" {
            url = GET_Medication
        } else if self.name == "physical activity" {
            url = GET_PHYSICAL_ACTIVITY
        } else {
            url = GET_SOCIAL_ACTIVITIES
        }
//
        WebServiceManager.post(params: idofAppointmet , serviceName: url, serviceType: "Get Current Medication" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    

    
    func getSurgicalHistory()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [  "id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Treatment, serviceType: "Get Allergies" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    
    func getImmunization()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [  "id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETImmunization, serviceType: "Get Allergies" , modelType: GetImmunization.self, success: { (response) in
            self.immunization = (response as! GetImmunization)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    
    func getAllFamilyHistory() {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        
        let idofAppointmet = [ "id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_Family, serviceType: "Consultant Detail" , modelType: GetPastDisease.self, success: { (response) in
            
            self.pastDisease = (response as! GetPastDisease)
            if self.pastDisease?.allDisease == nil {
                
            } else {
                if  self.pastDisease?.success == true {
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
    
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



