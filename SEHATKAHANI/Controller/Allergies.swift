//
//  Allergies.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class Allergies: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet weak var allergiesView: AnimatedView!
    @IBOutlet weak var allergiesButton: UIButton!
    @IBOutlet weak var typefoallergies: UILabel!
    @IBOutlet weak var symptoms: UILabel!
    @IBOutlet weak var symptomsButton: UIButton!
    @IBOutlet weak var treatment: UILabel!
    @IBOutlet weak var treatmentTextfield: UITextField!
    @IBOutlet var popUpView: ViewHolder!
    @IBOutlet var viewForTable: UIView!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var allergiesTable: UITableView!
    @IBOutlet var addbuttonView: UIViewX!
    
    @IBOutlet weak var drView: UIView!
    @IBOutlet weak var drAwardField: UITextField!
    
    @IBOutlet weak var cardTitle: UILabel!
    let blackView = BlackAndPopUPViews()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var parameterDictionary = [String:Any]()
    var allAllergies: Aller?
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
    var fra: CGRect!
    
    
    let allergies = ["Aspirin","Antiseizure drugs","Artificial food coloring and flavoring","Amoxicillin","Ampicillin","Abacavir","Autoimmune medications","Anti-seizure drugs","Barbiturates","Bees sting","Bee pollen products","Carbamazepine","Cetuximab","Chemotherapy drugs","Corticosteroid creams or lotions","Crustacean shellfish","Codeine","Dust","Dyes used in imaging tests (radiocontrast media)","Eggs","Environmental factors","Echinacea","Food items","Fish","Fire ants","HIV Medications","Hornets sting","Iodine","lamotrigine","ibuprofen","Insulin","Local anesthetics","Latex","Milk","Monoclonal antibody therapy","Non-Steroidal anti-inflammatory drugs (NSAIDs)","Naproxen","Nevirapine","Opiates","Penicillin","Pollen","Peanuts","Phenytoin","Seafood","Rituximab","Sedatives","Sulfa drugs","Soy","Salicylates","Tetracycline","Tree nuts","Wasps sting","Wheat","Yellow jackets"]
    
    let symptom = ["Abdominal pain","Abdominal swelling","Abnormal blood clotting","Abnormal reflexes","Abnormal thirst","Anaphylatic shock","Anxiety","Blood infection", "Chest discomfort","Consipation","Cough","Coughing up blood","Diarrhea","Difficulty swallowing","Dizziness","Easy bruising","Elevated liver enzymes","Enlarged glands","Excessive sleeping","Facial weekness","Fainting","Fast breathing","Fast heart rate","Fatigue","Fever","Flushing", "Frequent urination","Green or yellow phlegm","Growth problem","Hallucinations","Headache","Hearing changes","Heart murmur","Heart palpitations","Heartburn","Hiccough", "High blood pressure", "Hives(red,raised,itchy bumps)","Hyperventilation","Insomnia","Itching or numbness or tingling","Itchy watery eyes","Jaundice or yellow skin","Lack of co-ordination","Leakage of stool","Leakage of urine","Loss of appetite","Low blood count","Low blood pressure","Memory loss","Muscle aches","Nasal congestion/runny nose","Nausea or vomiting","Nausea only","Nosiy breathing","Nosebleed","Painful breathing","Painful urination","Paleness","Paralysis","Problem walking","Rash","Reduced urination","Retention of urine","Seizures","Shock","Shortness of breath","Smell or taste disturbance","Sneezing","Speech problem","Stiff neck","Sweating","Swelling","Throat pain","Twitching","Unconsciousness","Visual changes","Voice problem","Vomitting only","Weakness","Weight gain","Weight loss","Wheezing"]
    
    var array = [String]()
    var shift : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            cardTitle.text = "Awards"
        }else {
            cardTitle.text = "Allergies"
        }
        
        addbuttonView.isHidden = true
        allergiesTable.isHidden = true
        treatmentTextfield.delegate = self
        drAwardField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        allergiesView.animation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addMoreButton(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        blackView.close(popView: popUpView)
    }
    
    @IBAction func typeOfAllergy(_ sender: Any) {
        
        self.array = allergies
        tabelView.reloadData()
        self.shift = true
        
        self.viewForTable.frame = CGRect(x: self.allergiesButton.frame.origin.x, y: self.allergiesButton.frame.origin.y + self.allergiesButton.frame.height , width: self.allergiesButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(self.tabelView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.allergiesButton.frame.origin.x, y: self.allergiesButton.frame.origin.y + self.allergiesButton.frame.height, width: self.allergiesButton.frame.width, height: self.allergiesButton.frame.height * 5)
            self.tabelView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    
    @IBAction func symptoms(_ sender: Any) {
        self.array = symptom
        tabelView.reloadData()
        self.shift = false
        self.viewForTable.frame = CGRect(x: self.symptomsButton.frame.origin.x, y: self.symptomsButton.frame.origin.y + self.symptomsButton.frame.height , width: self.symptomsButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(self.tabelView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.symptomsButton.frame.origin.x, y: self.symptomsButton.frame.origin.y + self.symptomsButton.frame.height, width: self.symptomsButton.frame.width, height: self.symptomsButton.frame.height * 5)
            self.tabelView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    @IBAction func addNew(_ sender: Any) {
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            drView.isHidden = false
        }else {
            drView.isHidden = true
        }
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    @IBAction func none(_ sender: Any) {
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        addButton.isEnabled = false
        allergiesFunc()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == allergiesTable {
            return allAllergies?.result.count ?? 0
        }
        return self.array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == allergiesTable {
            let cell1 = allergiesTable.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = allAllergies?.result[indexPath.row].Reaction
            return cell1
        }
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if shift == true {
            typefoallergies.text = array[indexPath.row]
            typefoallergies.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)

        }else {
            symptoms.text = array[indexPath.row]
            symptoms.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        }
        viewForTable.removeFromSuperview()
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                self.viewMoveUp(popUpView: self.popUpView, value: self.treatmentTextfield)
                self.treatment.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            }
        }
    }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            treatment.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.popUpView.frame = self.fra
            gesture.isEnabled = true
            textField.resignFirstResponder()
            return true
        }
    
    
    func allergiesFunc() {
        let uid = APIManager.sharedInstance.getLoggedInUser()!.id!
        if APIManager.sharedInstance.getisdr() == true {
            self.parameterDictionary = [
                "email":(APIManager.sharedInstance.getLoggedInUser()?.email)!,
                "awards":"\(drAwardField.text!)"
            ]
        let vc = PastHistoryMedication()
            vc.drCard(parameterDictionary: self.parameterDictionary, url: "/api/MobileApp/profile/update_doctor_awards")
            self.blackView.close(popView: self.popUpView)
//              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)
        }else {
            var type = ""
            var symptom = ""
            var treatment = ""
            if typefoallergies.text! != "Type of Allergy" {
                type = typefoallergies.text!
            }
            if symptoms.text! != "Symptoms " {
                symptom = symptoms.text!
            }
            if treatmentTextfield.text! != "Treatmentpo" {
                treatment = treatmentTextfield.text!
            }
            
            let parameterDictionary = [
                "Type":"\(type)",
                "Reaction":"\(symptom)",
                "Notes":"\(treatment)",
                "id":uid
            ]
            let asd = AllergiesModel()
            asd.getAllAllergies(parameterDictionary: parameterDictionary) { (response) in
                DispatchQueue.main.async {
                    self.blackView.close(popView: self.popUpView)
                    asd.viewAllergies(parameterDictionary: ["id":uid], activityIndicator: self.activityIndicator, completion: { (allallergies) in
                        DispatchQueue.main.async {
                            self.allAllergies = allallergies
                            self.allergiesTable.isHidden = false
                            self.addbuttonView.isHidden = false
                            self.allergiesTable.reloadData()
                        }
                    })
                }
            }
        }
       addButton.isEnabled = true
    }
    

    func viewMoveUp(popUpView: UIView, value: UITextField) {
        gesture.isEnabled = false
        
        let window = UIApplication.shared.keyWindow!
        let abc = popUpView.frame.origin.y + (value.frame.origin.y + value.frame.height)
        print(abc)
        
        print("key height minus - ",window.frame.height - self.keyboardHeight)
        
        //        print("keybard height ",self.keyboardHeight)
        
        
        print(abc - (window.frame.height - self.keyboardHeight))
        let yahoo = abc - (window.frame.height - self.keyboardHeight)
        if yahoo > 0 {
            self.fra = popUpView.frame
            UIView.animate(withDuration: 0.3, animations: {
                popUpView.frame = CGRect(x: popUpView.frame.origin.x, y: popUpView.frame.origin.y - (yahoo  + 20), width: popUpView.frame.width, height: popUpView.frame.height)
            }) { (true) in
                
            }
        }
        
    }
    
    func keyboardWillShow(_ notification:Notification)
    {
        let userInfo:NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
        print("Inner = ",keyboardHeight)
    }
    
    
    
    
    
    
    
}


















