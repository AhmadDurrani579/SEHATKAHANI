//
//  SKSubLifeStyleHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 02/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKSubLifeStyleHistory: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var patientAllergies: GetAllergy?
    var pastDisease: GetPastDisease?
    var immunization: GetImmunization?
    var type: Int!
    var name: String!

    var index: Int!
    var array = [String]()
    let blackView = UIButton()
    var labelName : String!
    var mainArray = [String]()
    
    var isUpdate: Bool!
    var key: String!
    
    @IBOutlet weak var cardTBView: UITableView!
    @IBOutlet var cardTableView: UIView!

    
    //Add Current Medication
    @IBOutlet weak var addMedicationView: UIView!
    @IBOutlet weak var drugNameLbl: UITextField!
    @IBOutlet weak var commentLbl: UITextField!
    @IBOutlet weak var dosageLbl: UILabel!
    @IBOutlet weak var addCurrentMedication: UIButton!
    var dosage = 1
    
    //Social Activities
    @IBOutlet weak var socialActivityView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var frequencyField: UITextField!
    
    //Physical Activities
    @IBOutlet weak var phyActivityLbl: UILabel!
    @IBOutlet weak var phyActivityBtn: UIButton!
    
    
    var istakingTreatment:Bool = true
    
    let medications = ["Tobacco",
                 "Alcohol",
                 "Pan",
                 "Gutka",
                 "Chalia",
                 "Cigarette" ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isUpdate = false

        addCurrentMedication.cornerRad1()
        
        blackView.addTarget(self, action: #selector(self.removeBlackView), for: .touchUpInside)
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "FT_Add"), for: .normal)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.tintColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(self.precription), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        tableView.estimatedRowHeight = 130
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
            let pastDiseaseCel = UINib(nibName: "PatientSingleNoteCell", bundle: nil)
            tableView.register(pastDiseaseCel, forCellReuseIdentifier: "PatientSingleNoteCell")
        

            let SKPhysicalAndSocial = UINib(nibName: "SKPhysicalAndSocial", bundle: nil)
            tableView.register(SKPhysicalAndSocial, forCellReuseIdentifier: "SKPhysicalAndSocial")
            getCurrentMedication()
    }
    
    func removeBlackView() {
        blackView.removeFromSuperview()
        addMedicationView.removeFromSuperview()
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
    
    
    func precription() {
        if self.name == "current medication" || self.name ==  "physical activity"  || self.name == "social activity" {
         
            if self.name == "current medication" {
                addMedicationView.isHidden = false
                socialActivityView.isHidden = true
//                addFamilyHistory.isHidden = true
            } else if self.name == "physical activity" {
            
                socialActivityView.isHidden = false
                phyActivityBtn.isHidden = false
                phyActivityLbl.isHidden = false
                nameField.isHidden = true
//                addFamilyHistory.isHidden = true
//                addSurgeryView.isHidden = false
                //                self.dosage.text = "\(dosageCount)"
            } else if self.name == "social activity" {
//                    addMedicationView.isHidden = true
                    socialActivityView.isHidden = false
                    phyActivityBtn.isHidden = true
                    phyActivityLbl.isHidden = true
                    nameField.isHidden = false
//                cardPastHistoryView.isHidden =  true
//                addImmunizationView.isHidden = true
//                addFamilyHistory.isHidden = true
//                addDiseaseView.isHidden = false
//                addSurgeryView.isHidden = true
                //                self.dosage.text = "\(dosageCount)"
            }
            
            
            
            addViewHolder()
        } else if self.name == "past disease" {
            
        } else if self.name == "surgical history" {
            print("yahoo....")
        } else if self.name == "immunization" {
            print("yahoo....")
        } else if self.name == "family history" {
            print("yahoo....")
        }
    }
    
    func addViewHolder() {
        
        blackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        blackView.alpha = 0.8
        blackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addMedicationView.frame = CGRect(x: 30, y: self.view.frame.height + 50 , width: self.view.frame.width - 60, height: (self.view.frame.height / 2) + 50)
        self.view.addSubview(self.blackView)
        self.view.addSubview(self.addMedicationView)
        addMedicationView.layer.cornerRadius = 15
        addMedicationView.clipsToBounds = true
        UIView.animate(withDuration: 0.2, animations: {
            self.addMedicationView.frame.origin.y = (self.view.frame.height / 2) - 25
        }) { (true) in
            
        }

    }
    
    
//    @IBAction func isMedication(_ sender: Any) {
//        self.labelName = "currentmedication"
//        cardTableView.frame = CGRect(x: diseaseType.frame.origin.x, y: diseaseType.frame.origin.y + 30, width: self.diseaseType.frame.width, height: 130)
//        addDiseaseView.addSubview(cardTableView)
//        mainArray = medications
//        cardTBView.delegate = self
//        cardTBView.dataSource = self
//        cardTBView.reloadData()
//    }
    
    @IBAction func plusBtn(_ sender: Any) {
        self.dosage += 1
        self.dosageLbl.text = "\(self.dosage)"
    }
    @IBAction func minusBtn(_ sender: Any) {
        if self.dosage > 1 {
            self.dosage -= 1
            self.dosageLbl.text = "\(self.dosage)"
        }
    }
    
    @IBAction func addCurrentMedicationBtn(_ sender: Any) {
        if isUpdate {
            editLifeStyleHistory()
        }else {
          addLifeStyleHistory()
        }
        blackView.removeFromSuperview()
        addMedicationView.removeFromSuperview()
    }
    
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @IBAction func phyActivityBtn(_ sender: Any) {
        self.labelName = "phy"
                cardTableView.frame = CGRect(x: phyActivityLbl.frame.origin.x, y: phyActivityLbl.frame.origin.y, width: self.phyActivityLbl.frame.width, height: 130)
                socialActivityView.addSubview(cardTableView)
                mainArray = medications
                cardTBView.delegate = self
                cardTBView.dataSource = self
                cardTBView.reloadData()
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cardTBView {
            return mainArray.count
        }else {
            return self.patientAllergies?.treatment?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cardTBView {
            let cardCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  TypeOfDiseaseCell
            cardCell.typelabel.text = mainArray[indexPath.row]
            return cardCell
            
        }else {
        if self.type == 0  {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientSingleNoteCell", for: indexPath)   as! PatientSingleNoteCell
                cell.lblTitleOfSymptom.text = "Quantity"
                cell.lblTreatmentTitle.text = "Comments"
                cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].name
                cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].dosage
                cell.lblTreatment.text = self.patientAllergies?.treatment![indexPath.row].comments
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SKPhysicalAndSocial", for: indexPath)   as! SKPhysicalAndSocial
//            if type == 1{
                cell.title.text = self.patientAllergies?.treatment![indexPath.row].type1
                cell.subTitle.text = "Frequency"
                cell.comment.text = self.patientAllergies?.treatment![indexPath.row].Frequency
//            }
           
            return cell
        }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if self.labelName == "currentmedication" {
//            diseaseType.text = mainArray[indexPath.row]
//            diseaseType.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
//        }
        phyActivityLbl.text = medications[indexPath.row]
         cardTableView.removeFromSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == cardTBView {
            return 40
        }else {
            if self.type == 3 {
                return 265
            }
            return  150
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteBtn = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete") { (action , indexPath ) -> Void in
            self.isEditing = false
            
            if self.type == 0 {
                //++++++======++++=  current  ====+++====++=====++====+++++++=====+++++=====+++++======++++++==
                print("Deleted 0")
                self.deleteHistory(index: (self.patientAllergies?.treatment![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 1 {
                //++++++======++++=  physical  ====+++====++=====++====+++++++=====+++++=======++++=======++++======+++=
                print("Deleted 1")
                self.deleteHistory(index: (self.patientAllergies?.treatment![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 2 {
                //++++++======++++=  social  ====+++====++=====++====++++++=====++++++====+++++=====++++======++++======+
                print("Deleted 2")
                self.deleteHistory(index: (self.patientAllergies?.treatment![indexPath.row].key)!, deletedPath: indexPath)
            }
            print("Rate button pressed")
        }
        
        let editBtn = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit") { (action , indexPath) -> Void in
            self.isEditing = false
            print("Share button pressed")
            if self.type == 0 {
                //++++++======++++=  current key ====+++====++=====++====+++++++=====+++++=====+++++======++++++==
                self.addMedicationView.isHidden = false
                self.socialActivityView.isHidden = true
                self.key = self.patientAllergies?.treatment![indexPath.row].key
            } else if self.type == 1 {
                //++++++======++++=  physical key ====+++====++=====++====+++++++=====+++++=======++++=======++++======+++=
              
                self.socialActivityView.isHidden = false
                self.phyActivityBtn.isHidden = false
                self.phyActivityLbl.isHidden = false
                self.nameField.isHidden = true
                self.key = self.patientAllergies?.treatment![indexPath.row].key
            } else if self.type == 2 {
                //++++++======++++=  social key ====+++====++=====++====++++++=====++++++====+++++=====++++======++++======+
                self.socialActivityView.isHidden = false
                self.phyActivityBtn.isHidden = true
                self.phyActivityLbl.isHidden = true
                self.nameField.isHidden = false
                self.key = self.patientAllergies?.treatment![indexPath.row].key
            }
            self.isUpdate = true
            self.addViewHolder()
        }
        deleteBtn.backgroundColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        editBtn.backgroundColor = #colorLiteral(red: 8.143645165e-05, green: 0.78256358, blue: 0.5573937863, alpha: 1)
        return [deleteBtn, editBtn]
    }
    
    
    // DELETE MEDICAL HISTORIES  ==========+++++++++++++++++++==============++++++++++++++===========++++++++++++++++=============++++++++
    
    func deleteHistory(index: String , deletedPath: IndexPath) {
        var dict = [String : AnyObject]()
        var url: String!
        
        if self.name == "current medication" {
            url = DELETE_CURRENT_MEDICATION
            dict = [ "medicationId" : "\(index)"
                ] as [String : AnyObject]
            
        } else if self.name == "physical activity" {
            
            url = DELETE_PHYSICAL_ACTIVITY
            dict = [  "activityId" : "\(index)"
                ] as [String : AnyObject]
            
        } else if self.name == "social activity" {
            
            url = DELETE_SOCIAL_ACTIVITY
            dict = [  "activityId" : "\(index)"
                ] as [String : AnyObject]
            
        }
        
        
        WebServiceManager.post(params: dict , serviceName: url, serviceType: "Delete Life Style Medical History" , modelType: GetAllergy.self, success: { (response) in
            _ = (response as! GetAllergy)
            
            if self.type == 0 {
                //++++++======++++=  Allergy
                print("Deleted 0")
                self.patientAllergies?.treatment!.remove(at: deletedPath.row)
            } else if self.type == 1 {
                //++++++======++++=  Disease
                print("Deleted 1")
                self.patientAllergies?.treatment!.remove(at: deletedPath.row)
            } else if self.type == 2 {
                //++++++======++++=  Surgical
                print("Deleted 2")
                self.patientAllergies?.treatment!.remove(at: deletedPath.row)
            }
            
            self.tableView.deleteRows(at: [deletedPath], with: .automatic)
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
            
        }, showHUD: true)
    }
// EDIT MEDICAL HISTORY +=====+++===+++=+===++===++==++==++===++==+++==++===++==++===++==++==++==++===+==++==+====++
    
    func editLifeStyleHistory()  {
        let id = self.key
        var dict = [String : AnyObject]()
        var url: String!
        if self.name == "current medication" {
            url = EDIT_CURRENT_MEDICATION
            dict = [ "medicationId"            : id,
                     "Name"          : "\(drugNameLbl.text!)",
                "Dosage"      : "\(dosageLbl.text!)",
                "Comments"         : "\(commentLbl.text!)"
                ] as [String : AnyObject]
        }else if self.name == "social activity" {
            url = EDIT_SOCIAL_ACTIVITY
            dict = [  "activityId"            : id,
                      "Name"          : "\(nameField.text!)",
                "Frequency"       : "\(frequencyField.text!)"
                ] as [String : AnyObject]
        } else if self.name == "physical activity" {
            url = EDIT_PHYSICAL_ACTIVITY
            dict = [  "activityId"              : id,
                      "Name"            : "\(phyActivityLbl.text!)",
                "Frequency"             : "\(frequencyField.text!)"
                ] as [String : AnyObject]
        }
        
        WebServiceManager.post(params: dict , serviceName: url, serviceType: "Add Medical History" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            self.isUpdate = false
            self.getCurrentMedication()
           
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
            
        }, showHUD: true)
    }
// ADD MEDICAL HISTORY +=====+++===+++=+===++===++==++==++===++==+++==++===++==++===++==++==++==++===+==++==+====++
    
    
    func addLifeStyleHistory()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id!
        var dict = [String : AnyObject]()
        var url: String!
        if self.name == "current medication" {
            url = ADD_CURRENT_MEDICATION
            dict = [ "id"            : id,
                     "Name"          : "\(drugNameLbl.text!)",
                    "Dosage"      : "\(dosageLbl.text!)",
                    "Comments"         : "\(commentLbl.text!)"
                ] as [String : AnyObject]
        }else if self.name == "social activity" {
            url = ADD_SOCIAL_ACTIVITY
            dict = [  "id"            : id!,
                      "Name"          : "\(nameField.text!)",
                    "Frequency"       : "\(frequencyField.text!)"
                ] as [String : AnyObject]
        } else if self.name == "physical activity" {
            url = ADD_PHYSICAL_ACTIVITY
            dict = [  "id"              : id!,
                      "Name"            : "\(phyActivityLbl.text!)",
                    "Frequency"             : "\(frequencyField.text!)"
                ] as [String : AnyObject]
        }
        
        WebServiceManager.post(params: dict , serviceName: url, serviceType: "Add Medical History" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            self.getCurrentMedication()
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
            
        }, showHUD: true)
    }
    
    
// ADD MEDICAL HISTORY +=====+++===+++=+===++===++==++==++===++==+++==++===++==++===++==++==++==++===+==++==+====++
    

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
        
        if type == 0 {
            url = GET_Medication
        } else if type == 1 {
            url = GET_PHYSICAL_ACTIVITY
        } else {
            url = GET_SOCIAL_ACTIVITIES
        }
        
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


