//
//  Immunization.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class Immunization: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet var popUpView: ViewHolder!
    @IBOutlet weak var yes: UIButton!
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet weak var boosterlabel: UILabel!
    @IBOutlet var viewForTable: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var boosterTypeView: UIView!
    @IBOutlet weak var boosterNoView: UIView!
    @IBOutlet weak var vaccinationButton: UIButton!
    @IBOutlet weak var boosterButton: UIButton!
    @IBOutlet weak var vaccinationlabel: UILabel!
    @IBOutlet weak var boosterNoTestfield: UITextField!
    @IBOutlet weak var textfieldLabel: UILabel!
    @IBOutlet weak var immuView: AnimatedView!
    @IBOutlet weak var immuTableView: UITableView!
    @IBOutlet weak var addMoreView: UIViewX!
    @IBOutlet weak var cardTitle: UILabel!

    @IBOutlet weak var drTimefeildLabel: UILabel!
    @IBOutlet weak var drTimeField: UITextField!
    @IBOutlet weak var drFeeField: UITextField!
    @IBOutlet weak var drView: UIView!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var consultation: UIButton!
    
    let blackView = BlackAndPopUPViews()
    let radio = CurrentMedications()
    var table: Bool!
    var array = [String]()
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
    var fra: CGRect!
    
    let immu = ImmunizationModel()
    var immuResult: AllImmunization?
    var parameterDictionary = [String : Any]()
    
    var booster = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radio.selectedButtonImage(cirle: time, circle2: consultation)
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            cardTitle.text = "Fee Method"
        }else {
            cardTitle.text = "Immunization"
        }
        
        drTimeField.delegate = self
        drFeeField.delegate = self
        immuTableView.isHidden = true
        addMoreView.isHidden = true
        boosterNoTestfield.delegate = self
        
        drTimeField.text = ""
        drFeeField.text = ""

    }
    
    override func viewWillAppear(_ animated: Bool) {
        immuView.animation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

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
    @IBAction func drTimeButton(_ sender: Any) {
        drTimeField.isHidden = false
        drTimefeildLabel.isHidden = false
        radio.selectedButtonImage(cirle: time, circle2: consultation)
    }
    
    @IBAction func drCosultation(_ sender: Any) {
        drTimeField.isHidden = true
        drTimefeildLabel.isHidden = true
        radio.selectedButtonImage(cirle: consultation, circle2: time)
    }
    
    
    func gettingImmunization() {
        let uId = APIManager.sharedInstance.getLoggedInUser()!.id!
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            
            self.parameterDictionary = [
                "email":(APIManager.sharedInstance.getLoggedInUser()?.email)!,
                "fee1":"\(self.drFeeField.text!)",
                "fee2":"0",
                "timeslot":"\(self.drTimeField.text!)"
            ]
            
            let vc = PastHistoryMedication()
            vc.drCard(parameterDictionary: parameterDictionary, url: "/api/MobileApp/profile/update_doctor_fee")
            self.blackView.close(popView: self.popUpView)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)
            
        }else {
            if booster == true {
                self.parameterDictionary = [
                    "id":uId,
                    "Vaccination":"\(self.vaccinationlabel.text!)",
                    "Booster":true,
                    "Boostertype":"\(self.boosterlabel.text!)",
                    "Boosterfrequency":"\(self.boosterNoTestfield.text!)"
                ]
                
            }
            if booster == false {
                self.parameterDictionary = [
                    "id":uId,
                    "Vaccination":"\(self.vaccinationlabel.text!)"
                ]
            }
            
            immu.addImmunization(parameterDictionary: self.parameterDictionary) { (single) in
                //            print(single)
                DispatchQueue.main.async {
                    self.immu.allImmunization(parameterDictionary: ["id" : uId], completion: { (all) in
                        DispatchQueue.main.async {
                            self.immuResult = all
                            self.immuTableView.isHidden = false
                            self.addMoreView.isHidden = false
                            self.immuTableView.reloadData()
                        }
                    })
                    self.blackView.close(popView: self.popUpView)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func closePopUp(_ sender: Any) {
        blackView.close(popView: popUpView)
    }
    @IBAction func addMore(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    
    
    @IBAction func veccination(_ sender: Any) {
        self.array = ["Pneumococcal (for Pneumonia)","Hepatitis A","Hepatitis B","Diphtheria","Influenza (flu)","MMR (Mumps, Measles or Rubella)","Pneumococcal Conjugate Vaccine","Acellular Pertussis","Meningococcal","Rabies","Typhoid","Varicella (chicken pox)","Tetanus Toxoid","Bacillus Calmette Gueris (BCG)","Yellow fever","Cholera","DPT (diphtheria, pertussis (whooping cough), and tetanus)","Rotavirus vaccine","Polio vaccine","Human Papillomavirus (HPV)"]
        tableView.reloadData()
        self.table = true
        self.viewForTable.frame = CGRect(x: self.vaccinationButton.frame.origin.x, y: self.vaccinationButton.frame.origin.y + self.vaccinationButton.frame.height , width: self.vaccinationButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.vaccinationButton.frame.origin.x, y: self.vaccinationButton.frame.origin.y + self.vaccinationButton.frame.height, width: self.vaccinationButton.frame.width, height: self.vaccinationButton.frame.height * 5)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    @IBAction func boosterType(_ sender: Any) {
        self.array = ["Polio booster dose","Hepatitis B booster dose","Tetanus booster dose","Whooping cough booster dose"]
        tableView.reloadData()
        self.table = false
        
        self.viewForTable.frame = CGRect(x: self.boosterTypeView.frame.origin.x, y: self.boosterTypeView.frame.origin.y + self.boosterTypeView.frame.height , width: self.boosterTypeView.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.boosterTypeView.frame.origin.x, y: self.boosterTypeView.frame.origin.y + self.boosterTypeView.frame.height, width: self.boosterTypeView.frame.width, height: self.boosterTypeView.frame.height * 4)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    
    @IBAction func yes(_ sender: Any) {
        radio.selectedButtonImage(cirle: yes, circle2: no)
        self.booster = true
        UIView.animate(withDuration: 0.2) {
            self.boosterNoView.alpha = 0
            self.boosterTypeView.alpha = 1
        }
    }
    
    @IBAction func no(_ sender: Any) {
        radio.selectedButtonImage(cirle: no, circle2: yes)
        self.booster = false
        UIView.animate(withDuration: 0.2) {
            self.boosterNoView.alpha = 1
            self.boosterTypeView.alpha = 0
        }
    }
    
    
    @IBAction func add(_ sender: Any) {
        gettingImmunization()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == immuTableView {
            return immuResult?.result.count ?? 0
        }
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == immuTableView {
            let cell1 = immuTableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = immuResult?.result[indexPath.row].Vaccination
            return cell1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == immuTableView {}else {
        if table == true {
            vaccinationlabel.text = array[indexPath.row]
            vaccinationlabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        }else {
            boosterlabel.text = array[indexPath.row]
            boosterlabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        }
        viewForTable.removeFromSuperview()
    }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                self.viewMoveUp(popUpView: self.popUpView, value: self.boosterNoTestfield)
                self.textfieldLabel.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            }
        }
        
        
        textfieldLabel.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textfieldLabel.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.popUpView.frame = self.fra
        gesture.isEnabled = true
        textField.resignFirstResponder()
        return true
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
       
            self.fra = popUpView.frame
            UIView.animate(withDuration: 0.3, animations: {
                popUpView.frame = CGRect(x: popUpView.frame.origin.x, y: popUpView.frame.origin.y - (yahoo  + 20), width: popUpView.frame.width, height: popUpView.frame.height)
            }) { (true) in
                
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



















