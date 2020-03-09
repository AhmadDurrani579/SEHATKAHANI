//
//  CurrentMedications.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 16/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class CurrentMedications: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var dropdButtonOutlet: UIButton!
    @IBOutlet weak var typeOfDisease: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet var dropDownView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentHView: AnimatedView!
    
    @IBOutlet weak var addMoreView: UIViewX!
    @IBOutlet weak var diseaseTableView: UITableView!
    
    @IBOutlet weak var drYearfeild: UITextField!
    @IBOutlet weak var drMonthField: UITextField!
    @IBOutlet weak var drView: UIView!
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
    var fra: CGRect!
    
    @IBOutlet weak var cardTitle: UILabel!
    //    let window = UIApplication.shared.keyWindow!
//    var myNewView: UIButton!
//    var fr: CGRect!
    let yahoo = BlackAndPopUPViews()
    let medication = MedicationModel()
    
    var medicationResults: GetAllMedication?

     var parameterDictionary = [String : Any]()
    var takingMedicine = true
    var diseasetype = ""
    
    var count = 1
    
    let array = ["Abdominal Aortic Aneurysm",
    "Acanthamoeba Infection",
    "ACE",
    "Acinetobacter Infection",
    "Acquired Immune Deficiency Syndrome",
    "Acquired Immunodeficiency Syndrome",
    "Adenovirus Infection",
    "Adenovirus Vaccination"]
    
    
    
    @IBOutlet weak var drugNameLbl: UITextField!
    @IBOutlet weak var drugCountLbl: UILabel!
    @IBOutlet weak var additionalCommentsLbl: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalCommentsLbl.delegate = self
        drugNameLbl.delegate = self
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            cardTitle.text = "Experience"
        }else {
            cardTitle.text = "Current Medication"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        diseaseTableView.isHidden = true
        addMoreView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        currentHView.animation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closePopuP(_ sender: Any) {
        yahoo.close(popView: popUpView)
    }
    @IBAction func addMore(_ sender: Any) {
        yahoo.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    
    func medicationData() {
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{

            guard let textYesr = drYearfeild.text, !textYesr.isEmpty  else {
                APIManager.showAlertView(message: "Please enter valid data to continue")
                return
            }
            guard let drMonthFieldtxt = drMonthField.text, !drMonthFieldtxt.isEmpty  else {
                APIManager.showAlertView(message: "Please enter valid data to continue")
                return
            }
            self.parameterDictionary = [
                "email":(APIManager.sharedInstance.getLoggedInUser()?.email)!,
                "experience":"\(drYearfeild.text!)",
                 "experiencemonths":"\(drMonthField.text!)"
            ]
            let vc = PastHistoryMedication()
            vc.drCard(parameterDictionary: self.parameterDictionary, url: "/api/MobileApp/profile/update_doctor_experience")
             self.yahoo.close(popView: self.popUpView)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)
        }else {
                self.parameterDictionary = [
                    "id":APIManager.sharedInstance.getLoggedInUser()!.id!,
                    "Name":"\(self.drugNameLbl.text!)",
                    "Dosage": "\(self.drugCountLbl.text!)",
                    "Comments": "\(self.drugCountLbl.text!)"
                ]
            
            medication.addMadicationData(parameterDictionary: self.parameterDictionary) { (data) in
                DispatchQueue.main.async {
                    self.medication.allMedications(parameterDictionary: ["id" : APIManager.sharedInstance.getLoggedInUser()!.id!], completion: { (alldata) in
                        DispatchQueue.main.async {
                            self.diseaseTableView.isHidden = false
                            self.addMoreView.isHidden = false
                            self.medicationResults = alldata
                            self.diseaseTableView.reloadData()
                        }
                    })
                    self.yahoo.close(popView: self.popUpView)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func plusBtn( _ sender: Any) {
        
        self.count += 1
        drugCountLbl.text = "\(self.count)"
    }
    @IBAction func minusBtn(_ sender: Any) {
        if self.count > 1 {
            self.count -= 1
            drugCountLbl.text = "\(self.count)"
        }
    }
    
    
    
    @IBAction func dropDown(_ sender: Any) {
  self.dropDownView.frame = CGRect(x: self.dropdButtonOutlet.frame.origin.x, y: self.dropdButtonOutlet.frame.origin.y + self.dropdButtonOutlet.frame.height , width: self.dropdButtonOutlet.frame.width, height: 0)
        self.popUpView.addSubview(self.dropDownView)
        self.dropDownView.addSubview(self.tableView)

        UIView.animate(withDuration: 0.5, animations: {
            self.dropDownView.frame = CGRect(x: self.dropdButtonOutlet.frame.origin.x, y: self.dropdButtonOutlet.frame.origin.y + self.dropdButtonOutlet.frame.height, width: self.dropdButtonOutlet.frame.width, height: self.dropdButtonOutlet.frame.height * 5)
            self.tableView.frame = self.dropDownView.bounds
        }) { (true) in
        }
   
        
    }
    @IBAction func yesButton(_ sender: Any) {
        selectedButtonImage(cirle: yesButton, circle2: noButton)
        self.takingMedicine = true
    }
    @IBAction func noButton(_ sender: Any) {
        self.takingMedicine = false
        selectedButtonImage(cirle: noButton, circle2: yesButton)
    }
    @IBAction func addButton(_ sender: Any) {
        medicationData()
    }
    
    @IBAction func addNew(_ sender: Any) {
        
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            drView.isHidden = false
        }else {
            drView.isHidden = true
        }
        
        yahoo.BlackPopup(popView: popUpView, addButton: addButton)
    }
    @IBAction func none(_ sender: Any) {
    }
    
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    func closePopUp() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame.origin.y =  self.view.frame.height
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
             }, completion: { (true) in
                self.popUpView.removeFromSuperview()
            })
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == diseaseTableView {
            return medicationResults?.result.count ?? 0
        }
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == diseaseTableView {
            let cell1 = diseaseTableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = medicationResults?.result[indexPath.row].Name
            return cell1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        self.diseasetype = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        typeOfDisease.text = array[indexPath.row]
        typeOfDisease.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        dropDownView.removeFromSuperview()
    }
    
    
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                self.viewMoveUp(popUpView: self.popUpView, value: textField)
//                self.additionalCommentsLbl.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            }
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        additionalCommentsLbl.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.popUpView.frame = self.fra
//        gesture.isEnabled = true
        textField.resignFirstResponder()
        return true
    }
    
    
    func viewMoveUp(popUpView: UIView, value: UITextField) {
        self.fra = self.popUpView.frame
//        gesture.isEnabled = false
        let window = UIApplication.shared.keyWindow!
        let abc = popUpView.frame.origin.y + (value.frame.origin.y + value.frame.height)
        print(abc)
        
        print("key height minus - ",window.frame.height - self.keyboardHeight)
        
        //        print("keybard height ",self.keyboardHeight)
        
        
        print(abc - (window.frame.height - self.keyboardHeight))
        let yahoo = abc - (window.frame.height - self.keyboardHeight)
        if yahoo > 0 {
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






























