//
//  SKSubMedicalHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 01/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKSubMedicalHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
     @IBOutlet weak var pickerview: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cardTBView: UITableView!
    @IBOutlet weak var cardPastHistoryView: UIView!
    @IBOutlet weak var addDiseaseView: UIView!
    @IBOutlet weak var addSurgeryView: UIView!
    @IBOutlet weak var addImmunizationView: UIView!
    @IBOutlet weak var addFamilyHistory: UIView!

    @IBOutlet var cardTableView: UIView!
    @IBOutlet var cardViewHolder: ViewHolder!
    
    
    var patientAllergies: GetAllergy?
    var pastDisease: GetPastDisease?
    var immunization: GetImmunization?
    var type: Int!
    
    var array = [String]()
    
    var index: Int!
    var name: String!
    var isUpdate: Bool!
    var key: String!
    
    let blackView = UIButton()
    var labelName : String!
    
    //add Allergy fields.
    
    @IBOutlet weak var aTreatment: UITextField!
    @IBOutlet weak var aSymptomsLbl: UILabel!
    @IBOutlet weak var aTypeLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    //Add Disease
    @IBOutlet weak var diseaseType: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var adddisease: UIButton!
    var istakingTreatment:Bool = true
    
    //Add past history.
    @IBOutlet weak var addPastHistoryBtn : UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var duragName: UITextField!
    @IBOutlet weak var dosage: UILabel!
    var dosageCount = 1
    
    
    //Add surgical History
    @IBOutlet weak var typeOfSurgery : UILabel!
    @IBOutlet weak var reasonOfSurgery : UILabel!
    @IBOutlet weak var dateOfSurgery : UILabel!
    var surgeryDate: String!
    @IBOutlet weak var addSurgicalHistoryBtn : UIButton!
    
    
    
    //Add Immunization
    @IBOutlet weak var vaccinationLbl: UILabel!
    @IBOutlet weak var typeOfBooster: UILabel!
    @IBOutlet weak var nomberOfBooster: UITextField!
    @IBOutlet weak var immuYesBtn: UIButton!
    @IBOutlet weak var immuNoBtn: UIButton!
    @IBOutlet weak var addBtnImmu: UIButton!
    
    
    //Add family History
    @IBOutlet weak var familyDisease: UILabel!
    @IBOutlet weak var familyRelation: UILabel!
    @IBOutlet weak var addfamilyBtn: UIButton!
    
    
    
    
    
    
    
    let allergies = ["Aspirin","Antiseizure drugs","Artificial food coloring and flavoring","Amoxicillin","Ampicillin","Abacavir","Autoimmune medications","Anti-seizure drugs","Barbiturates","Bees sting","Bee pollen products","Carbamazepine","Cetuximab","Chemotherapy drugs","Corticosteroid creams or lotions","Crustacean shellfish","Codeine","Dust","Dyes used in imaging tests (radiocontrast media)","Eggs","Environmental factors","Echinacea","Food items","Fish","Fire ants","HIV Medications","Hornets sting","Iodine","lamotrigine","ibuprofen","Insulin","Local anesthetics","Latex","Milk","Monoclonal antibody therapy","Non-Steroidal anti-inflammatory drugs (NSAIDs)","Naproxen","Nevirapine","Opiates","Penicillin","Pollen","Peanuts","Phenytoin","Seafood","Rituximab","Sedatives","Sulfa drugs","Soy","Salicylates","Tetracycline","Tree nuts","Wasps sting","Wheat","Yellow jackets"]
    
    let symptom = ["Abdominal pain","Abdominal swelling","Abnormal blood clotting","Abnormal reflexes","Abnormal thirst","Anaphylatic shock","Anxiety","Blood infection", "Chest discomfort","Consipation","Cough","Coughing up blood","Diarrhea","Difficulty swallowing","Dizziness","Easy bruising","Elevated liver enzymes","Enlarged glands","Excessive sleeping","Facial weekness","Fainting","Fast breathing","Fast heart rate","Fatigue","Fever","Flushing", "Frequent urination","Green or yellow phlegm","Growth problem","Hallucinations","Headache","Hearing changes","Heart murmur","Heart palpitations","Heartburn","Hiccough", "High blood pressure", "Hives(red,raised,itchy bumps)","Hyperventilation","Insomnia","Itching or numbness or tingling","Itchy watery eyes","Jaundice or yellow skin","Lack of co-ordination","Leakage of stool","Leakage of urine","Loss of appetite","Low blood count","Low blood pressure","Memory loss","Muscle aches","Nasal congestion/runny nose","Nausea or vomiting","Nausea only","Nosiy breathing","Nosebleed","Painful breathing","Painful urination","Paleness","Paralysis","Problem walking","Rash","Reduced urination","Retention of urine","Seizures","Shock","Shortness of breath","Smell or taste disturbance","Sneezing","Speech problem","Stiff neck","Sweating","Swelling","Throat pain","Twitching","Unconsciousness","Visual changes","Voice problem","Vomitting only","Weakness","Weight gain","Weight loss","Wheezing"]
    
    let disease = ["Abdominal Aortic Aneurysm",
                 "Acanthamoeba Infection",
                 "ACE",
                 "Acinetobacter Infection",
                 "Acquired Immune Deficiency Syndrome",
                 "Acquired Immunodeficiency Syndrome",
                 "Adenovirus Infection",
                 "Adenovirus Vaccination"]
    
        let surgeryType = ["Eyes (cataract)", "Eyes (Glaucoma)","Ear","Nose","Sinuses","Tonsils","Thyroid","Parathyroid glands ","Heart valves repair or replacement","Arrhythmia Treatment","Coronary artery bypass grafting (CABG)","Aneurysm Repair","Lungs","Esophagus","Stomach (ulcer)","Bowel (small & large intestine)","Appendix","Liver (including hepatitis)","Gallbladder","Spleen","Hernia","Kidney","Bladder","Bone fracture repair","Joint replacement surgery","Neck","Spine","Brain","Skin","Breasts","Uterus","Prostate","Penis/Scrotal Surgery","Dental surgery","Cosmetic or plastic surgery"]
    
        let vaccinationType = ["Pneumococcal (for Pneumonia)","Hepatitis A","Hepatitis B","Diphtheria","Influenza (flu)","MMR (Mumps, Measles or Rubella)","Pneumococcal Conjugate Vaccine","Acellular Pertussis","Meningococcal","Rabies","Typhoid","Varicella (chicken pox)","Tetanus Toxoid","Bacillus Calmette Gueris (BCG)","Yellow fever","Cholera","DPT (diphtheria, pertussis (whooping cough), and tetanus)","Rotavirus vaccine","Polio vaccine","Human Papillomavirus (HPV)"]
    
        let boosterType = ["Polio booster dose","Hepatitis B booster dose","Tetanus booster dose","Whooping cough booster dose"]
    
        let listoffamilyDisease = [
            "Achondroplasia", "Alpha-1 Antitrypsin Deficiency","Alzheimer's", "Canavan disease","Cancer", "Charcot-Marie-Tooth","Colon cancer","Color blindness","Cri du chat","Crohn's Disease", "Cystic fibrosis","Dercum Disease","Diabetes","Down Syndrome","Duane Syndrome","Duchenne Muscular Dystrophy","Bleeding disorders","Endocrine Disorders","Autism","Factor V Leiden Thrombophilia","Familial Hypercholesterolemia","Familial Mediterranean Fever","Breast cancer","Autosomal Dominant Polycystic Kidney Disease","Asthma","Anesthesia complication","Antiphospholipid Syndrome","Fragile X Syndrome","Gaucher Disease","Heart Diseases","Hemochromatosis","Hemophilia","Hepatitis B"
        ]
    let relations = ["Father","Mother","Son","Daughter","Brother","Sister","Grandfather","Grandmother","Uncle","Aunt","Surrogate"]

    
     var allergyArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn.cornerRad1()
        adddisease.cornerRad1()
        addSurgicalHistoryBtn.cornerRad1()
        addBtnImmu.cornerRad1()
        addfamilyBtn.cornerRad1()
        
        self.isUpdate = false
        
        blackView.addTarget(self, action: #selector(SKSubMedicalHistory.removeBlackView), for: .touchUpInside)
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "FT_Add"), for: .normal)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.tintColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(SKSubMedicalHistory.precription), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)

        tableView.estimatedRowHeight = 130
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        let nibName = UINib(nibName: "PastDiseaseCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "PastDiseaseCell")
        

        if self.type == 0  || self.type == 2 {
            let nibName = UINib(nibName: "PatientSingleNoteCell", bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: "PatientSingleNoteCell")
            if self.type == 2 {
                getSurgicalHistory()
            }  else {
                getPatientPastHis()
            }
        }
        if self.type == 1 {
            let nibName = UINib(nibName: "PastDiseaseCell", bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: "PastDiseaseCell")
         
            getPastDisease()
        }
        if self.type == 3 {
            let nibName = UINib(nibName: "ImmunizationCell", bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: "ImmunizationCell")
            getImmunization()
        }
        if self.type == 4 {
            let SKPhysicalAndSocial = UINib(nibName: "SKPhysicalAndSocial", bundle: nil)
            tableView.register(SKPhysicalAndSocial, forCellReuseIdentifier: "SKPhysicalAndSocial")
            getAllFamilyHistory()
        }
   
        // Do any additional setup after loading the view.
    }
    
    func precription() {
        if self.name == "allergy" || self.name ==  "past disease"  || self.name == "surgical history" || self.name == "immunization" || self.name == "family history"{
            print("yahoo....")
            if self.name == "allergy" {
                cardPastHistoryView.isHidden =  true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true

            } else if self.name == "surgical history" {
                cardPastHistoryView.isHidden =  true
                addDiseaseView.isHidden = true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true
                addSurgeryView.isHidden = false
//                self.dosage.text = "\(dosageCount)"
            } else if self.name == "past disease" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true
                addDiseaseView.isHidden = false
                addSurgeryView.isHidden = true
                //                self.dosage.text = "\(dosageCount)"
            } else if self.name == "immunization" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = false
                addFamilyHistory.isHidden = true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                //                self.dosage.text = "\(dosageCount)"
            }else if self.name == "family history" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                addFamilyHistory.isHidden = false
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
        cardViewHolder.frame = CGRect(x: 30, y: self.view.frame.height + 50 , width: self.view.frame.width - 60, height: (self.view.frame.height / 2) + 50)
        self.view.addSubview(blackView)
        self.view.addSubview(cardViewHolder)
        cardViewHolder.layer.cornerRadius = 15
        cardViewHolder.clipsToBounds = true
        UIView.animate(withDuration: 0.2, animations: {
            self.cardViewHolder.frame.origin.y = (self.view.frame.height / 2) - 25
        }) { (true) in
            
        }
    }
    
    
    @IBAction func allergySelection(_ sender: Any) {
        self.labelName = "allergy"
        cardTableView.frame = CGRect(x: aTypeLbl.frame.origin.x, y: aTypeLbl.frame.origin.y + 30, width: self.aTypeLbl.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = allergies
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    @IBAction func symptomsSelection(_ sender: Any) {
        self.labelName = "symtoms"
        cardTableView.frame = CGRect(x: aSymptomsLbl.frame.origin.x, y: aSymptomsLbl.frame.origin.y + 30, width: self.aSymptomsLbl.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = symptom
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    
    //Add Allergy Button Action
    @IBAction func add(_ sender: Any) {
        if isUpdate {
            updateMedication(key: self.key)
        }else {
          addAllergies()
        }
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
    }
    @IBAction func plusBtn(_ sender: Any) {
        self.dosageCount += 1
        dosage.text = "\(self.dosageCount)"
        
    }
    @IBAction func minusBtn(_ sender: Any) {
        if self.dosageCount > 1 {
            self.dosageCount -= 1
            dosage.text = "\(self.dosageCount)"
        }
    }
    
    
    func removeBlackView() {
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
    }
    
    //Add Past History Button Action
     @IBAction func addPastHistoryAction(_ sender: Any) {
    
    }
    
    // Add diseases
    @IBAction func isMedication(_ sender: Any) {
        self.labelName = "disease"
        cardTableView.frame = CGRect(x: diseaseType.frame.origin.x, y: diseaseType.frame.origin.y + 30, width: self.diseaseType.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = disease
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    
    @IBAction func yes(_ sender: Any) {
        selectedButtonImage(cirle: yesBtn, circle2: noBtn)
        self.istakingTreatment = true
    }
    @IBAction func no(_ sender: Any) {
        selectedButtonImage(cirle: noBtn, circle2: yesBtn)
        self.istakingTreatment = false
    }
    @IBAction func addDisease(_ sender: Any) {
        if isUpdate {
            updateMedication(key: self.key)
        }else {
        addAllergies()
        }
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
    }
    
    //Add surgical History
    
    @IBAction func dateOfSurgeryAct(_ sender: Any)  {
        pickerview.frame = CGRect(x: 0, y: self.view.frame.height - 150, width: self.view.frame.width, height: 150)
        self.view.addSubview(pickerview)
        
    }
    @IBAction func typeOfSurgery(_ sender: Any)  {
        self.labelName = "surgery"
        cardTableView.frame = CGRect(x: typeOfSurgery.frame.origin.x, y: typeOfSurgery.frame.origin.y + 30, width: self.typeOfSurgery.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = surgeryType
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    @IBAction func addSurgery(_ sender: Any) {
        if isUpdate {
            updateMedication(key: self.key)
        }else {
        addAllergies()
        }
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
    }
    @IBAction func doneDate(_ sender: Any) {
        pickerview.removeFromSuperview()
    }
    
    func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        date.text = dateFormatter.string(from: picker.date)
        self.dateOfSurgery.text = dateFormatter.string(from: picker.date)
        dateOfSurgery.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
    }
    
    // Add immunization  +++++++++======+++++++=+++++++++++++=======+++++====
    
    @IBAction func vaccinationBtn(_ sender: Any) {
        self.labelName = "vaccination"
        cardTableView.frame = CGRect(x: vaccinationLbl.frame.origin.x, y: vaccinationLbl.frame.origin.y + 30, width: self.vaccinationLbl.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = vaccinationType
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    
    @IBAction func typeOfBoosterBtn(_ sender: Any) {
        self.labelName = "booster"
        cardTableView.frame = CGRect(x: vaccinationLbl.frame.origin.x, y: vaccinationLbl.frame.origin.y + 30, width: self.vaccinationLbl.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = boosterType
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    @IBAction func immYesBtn(_ sender: Any) {
        selectedButtonImage(cirle: immuYesBtn, circle2: immuNoBtn)
        self.istakingTreatment = true
    }
    @IBAction func immuNoBtn(_ sender: Any) {
        selectedButtonImage(cirle: immuNoBtn, circle2: immuYesBtn)
        self.istakingTreatment = false
    }
    
    @IBAction func addImmunization(_ sender: Any) {
        if isUpdate {
        updateMedication(key: self.key)
        }else {
        addAllergies()
        }
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
    }
    
    
    
    // Add Family History
    @IBAction func familyDisease(_ sender: Any) {
        self.labelName = "familyDisease"
        cardTableView.frame = CGRect(x: familyDisease.frame.origin.x, y: familyDisease.frame.origin.y + 30, width: self.familyDisease.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = listoffamilyDisease
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
        
    }
    
    @IBAction func familyRelation(_ sender: Any) {
        self.labelName = "familyRelation"
        cardTableView.frame = CGRect(x: familyRelation.frame.origin.x, y: familyRelation.frame.origin.y + 30, width: self.familyRelation.frame.width, height: 130)
        cardViewHolder.addSubview(cardTableView)
        allergyArray = relations
        cardTBView.delegate = self
        cardTBView.dataSource = self
        cardTBView.reloadData()
    }
    
    @IBAction func addFamilyHistory(_ sender: Any) {
        if isUpdate {
            updateMedication(key: self.key)
        }else {
        addAllergies()
        }
        blackView.removeFromSuperview()
        cardViewHolder.removeFromSuperview()
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

        if tableView == cardTBView {
            return allergyArray.count
        }else {
            if self.type == 0 || self.type == 2 {
                return self.patientAllergies?.treatment?.count ?? 0
            }
            else  if self.type == 3 {
                return self.immunization?.immunization?.count ?? 0
            } else if self.type == 4 {
                return self.pastDisease?.allDisease?.count ?? 0
                
            }
            else {
                return self.pastDisease?.allDisease?.count ?? 0
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cardTBView {
          let cardCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  TypeOfDiseaseCell
            cardCell.typelabel.text = allergyArray[indexPath.row]
            return cardCell

        }else {
            if self.type == 0 || self.type == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientSingleNoteCell", for: indexPath)   as! PatientSingleNoteCell
                if self.type == 2 {
                    cell.lblTitleOfSymptom.text = "Reason"
                    cell.lblTreatmentTitle.text = "Surgery Date"
                    cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].type1
                    cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].reason
                    // Get a character at X position (index)
                    if let str1 =  self.patientAllergies?.treatment![indexPath.row].dateOfSurger {
                        var str = str1
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
                        self.surgeryDate = subString
                        cell.lblTreatment.text = subString
                    }
                    
                }
                if self.type == 4 {
                    cell.lblTreatment.isHidden = true
                    cell.lblTreatmentTitle.isHidden = true
                } else if self.type == 0 {
                    cell.lblDrugName.text = self.patientAllergies?.treatment![indexPath.row].type1
                    cell.lblSymptom.text = self.patientAllergies?.treatment![indexPath.row].Reaction
                    cell.lblTreatment.text = self.patientAllergies?.treatment![indexPath.row].Notes
                }
                
                return cell
            }
            if self.type == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImmunizationCell", for: indexPath)   as! ImmunizationCell
                cell.lblBooster.text = self.immunization?.immunization![indexPath.row].Boostertype
                cell.lblNumberOfBooster.text =  self.immunization?.immunization![indexPath.row].Boosterfrequency
                cell.titleOfDiesease.text = self.immunization?.immunization![indexPath.row].Boostertype
                if self.immunization?.immunization![indexPath.row].Response == "Yes" {
                    cell.btnBooster.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
                }else {
                    cell.btnBooster.tintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                }
                return cell
            }
            if self.type == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SKPhysicalAndSocial", for: indexPath)   as! SKPhysicalAndSocial
               
                cell.title.text = self.pastDisease?.allDisease![indexPath.row].Disease
                cell.subTitle.text = "Relation"
                cell.comment.text = self.pastDisease?.allDisease![indexPath.row].Relation
              
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PastDiseaseCell", for: indexPath)   as! PastDiseaseCell
                cell.titleOfDiesease.text = self.pastDisease?.allDisease![indexPath.row].Disease
                if self.pastDisease?.allDisease![indexPath.row].Response == "Yes" {
                    cell.btnBooster.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
                }else {
                    cell.btnBooster.tintColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                }
                cell.btnBooster.setTitle(self.pastDisease?.allDisease![indexPath.row].Response, for: .normal)
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == cardTBView {
            if self.labelName == "allergy" {
                aTypeLbl.text = allergyArray[indexPath.row]
                aTypeLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "symtoms" {
                aSymptomsLbl.text = allergyArray[indexPath.row]
                aSymptomsLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "disease" {
                diseaseType.text = allergyArray[indexPath.row]
                diseaseType.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "surgery" {
                typeOfSurgery.text = allergyArray[indexPath.row]
                typeOfSurgery.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "vaccination" {
                vaccinationLbl.text = allergyArray[indexPath.row]
                vaccinationLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "booster" {
                typeOfBooster.text = allergyArray[indexPath.row]
                typeOfBooster.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "familyDisease" {
                familyDisease.text = allergyArray[indexPath.row]
                familyDisease.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }else if self.labelName == "familyRelation" {
                familyRelation.text = allergyArray[indexPath.row]
                familyRelation.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            }
            
            cardTableView.removeFromSuperview()
        }
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
                //++++++======++++=  Allergy  ====+++====++=====++====+++++++=====+++++=====+++++======++++++==
                print("Deleted 0")
                self.deleteHistory(index: (self.patientAllergies?.treatment![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 1 {
                //++++++======++++=  Disease  ====+++====++=====++====+++++++=====+++++=======++++=======++++======+++=
                print("Deleted 1")
                self.deleteHistory(index: (self.pastDisease?.allDisease![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 2 {
                //++++++======++++=  Surgical  ====+++====++=====++====++++++=====++++++====+++++=====++++======++++======+
                print("Deleted 2")
                self.deleteHistory(index: (self.patientAllergies?.treatment![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 3 {
                //++++++======++++=  Immunization  ====+++====++=====++====++++++====++++++===+++++++====+++++=====+++=======+==
                print("Deleted 3")
                self.deleteHistory(index: (self.immunization?.immunization![indexPath.row].key)!, deletedPath: indexPath)
            } else if self.type == 4 {
                //++++++======++++=  Family  ====+++====++=====++====++++++======+++++=====++++======++++======+++======
                self.deleteHistory(index: (self.pastDisease?.allDisease![indexPath.row]._id)!, deletedPath: indexPath)
                print("Deleted 4")
            }
            print("Rate button pressed")
        }
        
        let editBtn = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit") { (action , indexPath) -> Void in
            self.isEditing = false
            
            self.isUpdate = true
            self.editMedicalHistory(index: indexPath)
            
            if self.type == 0 {
                //++++++======++++=  Allergy  ====+++====++=====++====+++++++=====+++++=====+++++======++++++==
                print("Deleted 0")
                self.key = self.patientAllergies?.treatment![indexPath.row].key
            } else if self.type == 1 {
                //++++++======++++=  Disease  ====+++====++=====++====+++++++=====+++++=======++++=======++++======+++=
                print("Deleted 1")
                self.key =  self.pastDisease?.allDisease![indexPath.row].key
            } else if self.type == 2 {
                //++++++======++++=  Surgical  ====+++====++=====++====++++++=====++++++====+++++=====++++======++++======+
                print("Deleted 2")
                self.key = self.patientAllergies?.treatment![indexPath.row].key
            } else if self.type == 3 {
                //++++++======++++=  Immunization  ====+++====++=====++====++++++====++++++===+++++++====+++++=====+++=======+==
                print("Deleted 3")
                self.key = self.immunization?.immunization![indexPath.row].key
            } else if self.type == 4 {
                //++++++======++++=  Family  ====+++====++=====++====++++++======+++++=====++++======++++======+++======
                self.key = self.pastDisease?.allDisease![indexPath.row]._id
                print("Deleted 4")
            }

            
            
            print("Share button pressed")
        }
        deleteBtn.backgroundColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        editBtn.backgroundColor = #colorLiteral(red: 8.143645165e-05, green: 0.78256358, blue: 0.5573937863, alpha: 1)
        return [deleteBtn, editBtn]
    }
    
    
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    
    
    func editMedicalHistory(index: IndexPath) {
        if self.name == "allergy" || self.name ==  "past disease"  || self.name == "surgical history" || self.name == "immunization" || self.name == "family history"{
            print("yahoo....")
            if self.name == "allergy" {
                cardPastHistoryView.isHidden =  true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true
                aSymptomsLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
                aTypeLbl.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
               
            } else if self.name == "surgical history" {
                cardPastHistoryView.isHidden =  true
                addDiseaseView.isHidden = true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true
                addSurgeryView.isHidden = false
        
                //                self.dosage.text = "\(dosageCount)"
            } else if self.name == "past disease" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = true
                addFamilyHistory.isHidden = true
                addDiseaseView.isHidden = false
                addSurgeryView.isHidden = true
                //                self.dosage.text = "\(dosageCount)"
            } else if self.name == "immunization" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = false
                addFamilyHistory.isHidden = true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                //                self.dosage.text = "\(dosageCount)"
            }else if self.name == "family history" {
                cardPastHistoryView.isHidden =  true
                addImmunizationView.isHidden = true
                addDiseaseView.isHidden = true
                addSurgeryView.isHidden = true
                addFamilyHistory.isHidden = false
                //                self.dosage.text = "\(dosageCount)"
            }
            
            
            
            addViewHolder()
        } else {
            print("yahoo....")
        }
    }
    
  
//==========+++++++++++++++++++==============++++++++++++++===========++++++++++++++++=============+++++++++++++++++++==============++++++++++++++++++===========++++

    
    

        
    
        func addAllergies()  {
            let id = APIManager.sharedInstance.getLoggedInUser()?.id!
            var dict = [String : AnyObject]()
            var url: String!
            if self.name == "allergy" {
                url = ADD_ALLERGY
                dict = [ "id"            : id,
                        "type"          : "\(aTypeLbl.text!.capitalized)",
                        "Reaction"      : "\(aSymptomsLbl.text!.capitalized)",
                        "Notes"         : "\(aTreatment.text!)"
                    ] as [String : AnyObject]
            } else if self.name == "past disease" {
                url = ADD_DISEASE
                dict = [  "id"            : id!,
                          "Disease"          : "\(diseaseType.text!)",
                          "Treatment"      : self.istakingTreatment
                    ] as [String : AnyObject]
            } else if self.name == "surgical history" {
                url = ADD_SURGICAL_HISTORY
                dict = [  "id"              : id!,
                          "Type"            : "\(typeOfSurgery.text!)",
                        "Reason"             : "\(reasonOfSurgery.text!)",
                        "dateofsurgery"      : "\(dateOfSurgery.text!)",
                    ] as [String : AnyObject]
            } else if self.name == "immunization" {
                url = ADD_IMMUNIZATION
                dict = [  "id"              : id!,
                          "Vaccination"            : "\(vaccinationLbl.text!)",
                            "Booster"             : self.istakingTreatment,
                            "Boostertype"      : "\(typeOfBooster.text!)",
                            "Boosterfrequency"      : "\(nomberOfBooster.text!)"
                    ] as [String : AnyObject]
            }else if self.name == "family history" {
                url = ADD_FAMILY
                dict = [  "id"              : id!,
                          "Disease"            : "\(familyDisease.text!)",
                        "Relation"             : "\(familyRelation.text!)"
                    ] as [String : AnyObject]
            }
            
        
            WebServiceManager.post(params: dict , serviceName: url, serviceType: "Add Medical History" , modelType: GetAllergy.self, success: { (response) in
                self.patientAllergies = (response as! GetAllergy)
                
                if self.name == "allergy" {
                    self.getPatientPastHis()
                } else if self.name == "surgical history" {
                    self.getSurgicalHistory()
                } else if self.name == "past disease" {
                    self.getPastDisease()
                } else if self.name == "immunization" {
                    self.getImmunization()
                }else {
                    self.getAllFamilyHistory()
                }
            }, fail: { (error) in
                APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
                
            }, showHUD: true)
        }
    
// EDIT MEDICAL HISTORIES  ==========+++++++++++++++++++==============++++++++++++++===========++++++++++++++++=============++++++++
    
    func updateMedication(key: String)  {
        var id = self.key
        var dict = [String : AnyObject]()
        var url: String!
        if self.name == "allergy" {
            url = EDIT_ALLERGY
            dict = [ "allergyId"            : id,
                     "type"          : "\(aTypeLbl.text!.capitalized)",
                "Reaction"      : "\(aSymptomsLbl.text!.capitalized)",
                "Notes"         : "\(aTreatment.text!)"
                ] as [String : AnyObject]
        } else if self.name == "past disease" {
            url = EDIT_PAST_DISEASE
            dict = [  "diseaseId"            : id,
                      "Disease"          : "\(diseaseType.text!)",
                "Treatment"      : self.istakingTreatment
                ] as [String : AnyObject]
        } else if self.name == "surgical history" {
            url = EDIT_SURGICAL
            dict = [  "treatmentId"              : id,
                      "Type"            : "\(typeOfSurgery.text!)",
                "Reason"             : "\(reasonOfSurgery.text!)",
                "dateofsurgery"      : "\(dateOfSurgery.text!)",
                ] as [String : AnyObject]
        } else if self.name == "immunization" {
            url = EDIT_IMMUNIZATION
            dict = [  "immunizationId"              : id,
                      "Vaccination"            : "\(vaccinationLbl.text!)",
                "Booster"             : self.istakingTreatment,
                "Boostertype"      : "\(typeOfBooster.text!)",
                "Boosterfrequency"      : "\(nomberOfBooster.text!)"
                ] as [String : AnyObject]
        }else if self.name == "family history" {
            url = EDIT_FAMILY
            dict = [  "famhisId"              : id,
                      "Disease"            : "\(familyDisease.text!)",
                "Relation"             : "\(familyRelation.text!)"
                ] as [String : AnyObject]
        }
        
        
        WebServiceManager.post(params: dict , serviceName: url, serviceType: "Add Medical History" , modelType: GetAllergy.self, success: { (response) in
            self.patientAllergies = (response as! GetAllergy)
            //                self.tableView.delegate = self
            //                self.tableView.dataSource = self
            //                self.tableView.reloadData()
            self.isUpdate = false
            
            
            if self.name == "allergy" {
              self.getPatientPastHis()
            } else if self.name == "surgical history" {
              self.getSurgicalHistory()
            } else if self.name == "past disease" {
                self.getPastDisease()
            } else if self.name == "immunization" {
            self.getImmunization()
            }else {
            self.getAllFamilyHistory()
            }

            
            
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
        }, showHUD: true)
    }
    
    
// DELETE MEDICAL HISTORIES  ==========+++++++++++++++++++==============++++++++++++++===========++++++++++++++++=============++++++++

    func deleteHistory(index: String , deletedPath: IndexPath) {
        var dict = [String : AnyObject]()
        var url: String!
        
        if self.name == "allergy" {
            
            url = DELETE_ALLERGY
            dict = [ "allergyId" : "\(index)"
                ] as [String : AnyObject]
            
        } else if self.name == "past disease" {
            
            url = DELETE_DISEASE
            dict = [  "diseaseId" : "\(index)"
                ] as [String : AnyObject]
            
        } else if self.name == "surgical history" {
            
            url = DELETE_SURGICAL
            dict = [  "treatmentId" : "\(index)"
                ] as [String : AnyObject]
            
        } else if self.name == "immunization" {
            
            url = DELETE_IMMUNIZATION
            dict = [  "immunizationId" : "\(index)"
                ] as [String : AnyObject]
            
        }else if self.name == "family history" {
            
            url = DELETE_FAMILY
            dict = [  "famhisId" : "\(index)"
                ] as [String : AnyObject]
            
        }
        
        
        WebServiceManager.post(params: dict , serviceName: url, serviceType: "Delete Medical History" , modelType: GetAllergy.self, success: { (response) in
            _ = (response as! GetAllergy)
  
            if self.type == 0 {
//++++++======++++=  Allergy
                print("Deleted 0")
                self.patientAllergies?.treatment!.remove(at: deletedPath.row)
            } else if self.type == 1 {
//++++++======++++=  Disease
                print("Deleted 1")
                self.pastDisease?.allDisease!.remove(at: deletedPath.row)
            } else if self.type == 2 {
//++++++======++++=  Surgical
                print("Deleted 2")
                self.patientAllergies?.treatment!.remove(at: deletedPath.row)
            } else if self.type == 3 {
//++++++======++++= Immunization
                print("Deleted 3")
                self.immunization?.immunization!.remove(at: deletedPath.row)
            } else if self.type == 4 {
//++++++======++++=  Family
                self.pastDisease?.allDisease!.remove(at: deletedPath.row)
                print("Deleted 4")
            }

             self.tableView.deleteRows(at: [deletedPath], with: .automatic)
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
            
        }, showHUD: true)
    }
    
//==========+++++++++++++++++++==============++++++++++++++===========++++++++++++++++=============+++++++++++++++++++==============
    
    

    
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
    
    func getPastDisease()  {
        let id = APIManager.sharedInstance.getLoggedInUser()?.id
        
        let idofAppointmet = [  "id"        : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_PastDisease, serviceType: "Get Diseases" , modelType: GetPastDisease.self, success: { (response) in
            self.pastDisease = (response as! GetPastDisease)
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
    
//+++++++++++++++++++==================++++++++++++++=============+++++++++++++++=================++++++++++++++++=================++++++++++++===========
    
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

