//
//  SignUp.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 29/09/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//AB

import UIKit

class SignUp: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var licenseField: UITextField!
    @IBOutlet weak var doctorButton: UIButton!
    @IBOutlet weak var patientButton: UIButton!
    @IBOutlet weak var specialityButton: UIButton!
    @IBOutlet var popUpView: UIViewX!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var specialityView: UIView!
    
    var continueButtY: CGFloat!
    var yaoo: CGFloat!
   var data = ["Anesthesiologist", "Allergy Specialist", "Audiologist", "Chiropractor", "Cosmetic Surgeon", "Dermatologist", "Dental", "Diabetes Specialist", "ENT Specialist", "Endocrinologist", "Gastroenterologist", "Gynecologist", "General Surgeon", "General Physician", "Hematologist", "Hair Transplant Surgeon", "Infertility Specialist", "Nutritionist / Dietitian", "Nephrologist", "Neuro Surgeon", "Orthopedic", "Orthopedic Surgeon", "Oncologist / Cancer specialist", "Ophthalmologist / Eye Specialist", "Plastic Surgeon", "Psychologist", "Psychiatrist", "Physiotherapist", "Pediatrician / Child specialist", "Pulmonologist / Lungs specialist", "Radiologist", "Sonologist", "Urologist" ,"Vascular Surgeon","Wellness Coach"]
    let backview = UIViewX()
    var url: String!
    
    enum `Type1` {
        case doctor
        case patient
    }
    var togle = false
    
    var type: Type1!
    
    var parameterDictionary = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.delegate = self
        nameField.delegate = self
        lastname.delegate = self
        email.delegate = self
        password.delegate = self
        licenseField.delegate = self
        
     
        
        UIView.animate(withDuration: 0.5) {
            self.nameField.alpha = 0
            self.lastname.alpha = 0
            self.email.alpha = 0
            self.licenseField.alpha = 0
            self.password.alpha = 0
            self.continueButton.alpha = 0
        }
        // Do any additional setup after loading the view.
        
        //        yaoo = 0
        //        self.yaoo = self.continueButton.center.y
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        nameField.padding(value: 15)
        lastname.padding(value: 15)
        email.padding(value: 15)
        password.padding(value: 15)
        licenseField.padding(value: 15)
        specialityView.layer.cornerRadius = self.specialityView.frame.height / 1.9
        specialityView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        specialityView.layer.borderWidth = 1
        
        nameField.layer.cornerRadius = self.nameField.frame.height / 1.9
        lastname.layer.cornerRadius = self.lastname.frame.height / 1.9
        email.layer.cornerRadius = self.email.frame.height / 1.9
        password.layer.cornerRadius = self.password.frame.height / 1.9
        licenseField.layer.cornerRadius = self.licenseField.frame.height / 1.9
        continueButton.layer.cornerRadius = self.continueButton.frame.height / 1.9


        
        //        self.continueButtY = self.continueButton.center.y
        //        print(" Continue Button : - ",self.continueButtY)
        //        print(" Continue Yahoo value : - ",self.yaoo)
        doctorButton.sendActions(for: .touchUpInside)
        //        self.continueButton.center.y = self.licenseField.center.y + self.licenseField.frame.height * 1.5
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //        self.continueButton.center.y =  self.continueButton.center.y + ( self.licenseField.frame.height / 2 )
        nameField.textcor()
        lastname.textcor()
        email.textcor()
        password.textcor()
        continueButton.cornerRad()
        specialityButton.cornerRad()
        licenseField.textcor()
        
        
        UIView.animate(withDuration: 0.5) {
            self.nameField.alpha = 1
            self.lastname.alpha = 1
            self.email.alpha = 1
            self.licenseField.alpha = 1
            self.password.alpha = 1
            self.continueButton.alpha = 1
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.nameField.alpha = 0
            self.lastname.alpha = 0
            self.email.alpha = 0
            self.licenseField.alpha = 0
            self.password.alpha = 0
            self.continueButton.alpha = 0
        }
        self.togle = false
        print(" Continue Button : - ",self.continueButtY)
        print(" Continue Yahoo value : - ",self.yaoo)
        
    }
    
    @IBAction func DoctorButton(_ sender: Any) {
        APIManager.sharedInstance.isdr(dr: true)
        selectedButtonImage(cirle: doctorButton, circle2: patientButton)
        
        UIView.animate(withDuration: 0.3) {
            self.licenseField.alpha = 1
            self.specialityView.alpha = 1
            if self.licenseField.alpha == 1 {
                if self.togle == false {
                    //                    self.continueButton.center.y =  self.continueButton.center.y + ( self.licenseField.frame.height / 2 )
                }
                self.togle = true
            }
        }
        self.type = Type1.doctor
        
    }
    @IBAction func patientButton(_ sender: Any) {
        APIManager.sharedInstance.isdr(dr: false)
        //            print(" Continue Button : - ",self.continueButtY)
        selectedButtonImage(cirle: patientButton, circle2: doctorButton)
        
        UIView.animate(withDuration: 0.3) {
            self.licenseField.alpha = 0
            self.specialityView.alpha = 0
            //                self.continueButton.center.y = self.licenseField.center.y + self.licenseField.frame.height
        }
        self.type = Type1.patient
        self.togle = false
        
    }
    
    
    @IBAction func signUpContinue(_ sender: Any) {
        //<<<<<<< HEAD
//
//                if self.type == Type.patient {
//                  signUp()
//                }
//                let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "genderSelection") as UIViewController
//                self.present(vc, animated: true, completion: nil)
//


        guard let text = nameField.text, !text.isEmpty else {
            APIManager.showAlertView(message: "Please enter your first name")
            return
        }
        guard let lastName = lastname.text, !lastName.isEmpty else {
            APIManager.showAlertView(message: "Please enter your last name")
            return
        }
        guard let emailName = email.text, !emailName.isEmpty else {
            APIManager.showAlertView(message: "Please enter your email")
            return
        }
        guard let passwordTxt = password.text, !passwordTxt.isEmpty else {
            APIManager.showAlertView(message: "Please enter your password")
            return
        }
                if self.type == Type1.patient {
                    signUp()
                }else {
                    guard let specialityLabeltxt = specialityLabel.text, !specialityLabeltxt.isEmpty else {
                        APIManager.showAlertView(message: "Please select your speciality")
                        return
                    }
                    guard let licenseFieldtext = licenseField.text, !licenseFieldtext.isEmpty else {
                        APIManager.showAlertView(message: "Please enter your PMDC Number")
                        return
                    }
                    signUp()
                }
        ////>>>>>>> Development-zia
    }
    
    @IBAction func specialitySelection(_ sender: Any) {
        
        self.view.endEditing(true);

        backview.frame = (UIApplication.shared.keyWindow?.bounds)!
        backview.backgroundColor =  UIColor(red: 0.9999960065, green: 1, blue: 1, alpha: 0.503021816)
        popUpView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (UIApplication.shared.keyWindow?.frame.height)! / 3.5)
        popUpView.frame.origin.y = (UIApplication.shared.keyWindow?.frame.height)! - popUpView.frame.height
        UIApplication.shared.keyWindow?.addSubview(backview)
        UIApplication.shared.keyWindow?.addSubview(popUpView)
        guard let text = specialityLabel.text, text != "Select Speciality"  else {
            specialityLabel.text = data[0]
            specialityLabel.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            return;
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(data[row])
        specialityLabel.text = data[row]
        specialityLabel.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
    }
    
    @IBAction func done(_ sender: Any) {
        popUpView.removeFromSuperview()
        backview.removeFromSuperview()
        
    }
    func signUp() {
        
        print(self.type)
        if self.type == Type1.patient {
            self.parameterDictionary = [
                "firstname":"\(nameField.text!)",
                "lastname":"\(lastname.text!)",
                "email":"\(email.text!)",
                "password":"\(password.text!)"
            ]
            self.url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/patient_signup")
        }else {
            self.parameterDictionary = [
                "firstname":"\(nameField.text!)",
                "lastname":"\(lastname.text!)",
                "email":"\(email.text!)",
                "password":"\(password.text!)",
                "speciality":"\(specialityLabel.text!)",
                "medno":"\(licenseField.text!)"
            ]
            self.url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/doctor_signup")
        }
        
        
        guard let serviceUrl = URL(string: url) else { return }
        
        if nameField.text != "" && email.text != "" && password.text != "" && lastname.text != "" {
            
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            
            
            APIManager.sharedInstance.showHud();
            
            session.dataTask(with: request) { (data, response, error) in
                APIManager.sharedInstance.hideHud()
                
                if error != nil {
                    print(error)
                    return
                }
                if let response = response {
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse.statusCode)
                }
                if let data = data {
                    do {
                        if  let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSDictionary {
                            //                            print(json)
                            if let message = json["User"] as? NSDictionary{
                                
                                if let userInfoData = message as? [String : AnyObject] {
                                    if let user: SKUser = SKUser(JSON: userInfoData) {
                                        debugPrint(user.name);
                                        APIManager.sharedInstance.saveLoggedInUser(user: user);
                                        if(user.isDoctor)!{
                                            DispatchQueue.main.async(execute: {
                                                let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                                let vc = storyboard.instantiateViewController(withIdentifier: "doctorBasicProfile") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                            })
                                            
                                        }else{
                                            
                                            DispatchQueue.main.async(execute: {
                                                let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                                let vc = storyboard.instantiateViewController(withIdentifier: "genderSelection") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                            })
                                        }
                                    }
                                }
                                
                            }else {

                                if (json["message"] as? String) != nil{
                                    let errorMessage = json["message"] as! String
                                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: errorMessage )
                                }else {
                                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Unable to signUP, Please enter correct information")
                                }
            }
                        }else {
                            
                            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Unable to signUP, Please enter correct information")
                            print("Error loading")
                        }
                        
                    }catch {
                        print(error)
                        return
                    }
                }
                }.resume()
        }else {
        }
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == email {
            if !(email.text?.isValidEmail())! {
                APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Invalid emial address.!")
                email.text = ""
            }
        }
        textField.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}

