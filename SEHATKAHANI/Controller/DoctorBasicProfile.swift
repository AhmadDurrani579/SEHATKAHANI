
//
//  DoctorBasicProfile.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 27/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class DoctorBasicProfile:  UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var maritalstatusSubView: UIView!
    @IBOutlet var maritalstatusView: UIView!
    @IBOutlet weak var bgTypeLabel: UILabel!
    @IBOutlet var bgType: UIView!
    
    @IBOutlet weak var bloodgroupView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var heightTextfield: UITextField!
    @IBOutlet weak var workAddress: UITextField!
      @IBOutlet weak var dragebtn: UIButton!
    
    @IBOutlet var popUpView: UIViewX!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var workContact: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var contyView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet var pickerViewx: UIViewX!
    @IBOutlet weak var pickerView1: UIDatePicker!
    
    var data = ["Pakistan","India","America","China"]
    var data1 = ["Punjab","Sind","KPK","Kashmir"]
    var arraydata = [String]()
    let backview = UIViewX()
    
    enum `Type1` {
        case country
        case state
    }
    
    var type: Type1!
    var bg = ""
    var height = ""
    var weight = ""
    var dob = "2000-03-03"
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        ageTextfield.delegate = self
        heightTextfield.delegate = self
        workAddress.delegate = self
        phone.delegate = self
        workContact.delegate = self
        city.delegate = self
        address.delegate = self
        pickerView.delegate = self
        
        stateLabel.text = data.first
        countryLabel.text = data1.first
        
        maritalstatusView.xView(value: 2)
        maritalstatusView.xViewborder(bordervalue: 1, borderColor: #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1))
        
        bloodgroupView.xViewborder(bordervalue: 1, borderColor: #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1))
        bloodgroupView.xView(value: 2)
        
        stateView.xViewborder(bordervalue: 1, borderColor: #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1))
        stateView.xView(value: 2)
        
        contyView.xViewborder(bordervalue: 1, borderColor: #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1))
        contyView.xView(value: 2)
        
        ageTextfield.padding(value: 15)
        //        holderView.layer.cornerRadius  = holderView.frame.height / 19
        //        shadowView.layer.cornerRadius = shadowView.frame.height / 19
        
        ageTextfield.textcor()
        ageTextfield.padding(value: 15)
        
        city.textcor()
        city.padding(value: 15)
        
        address.textcor()
        address.padding(value: 15)
        
        phone.textcor()
        phone.padding(value: 8)
        
        workContact.textcor()
        workContact.padding(value: 8)
        
        heightTextfield.textcor()
        heightTextfield.padding(value: 8)
        
        workAddress.textcor()
        workAddress.padding(value: 15)
        
        continueButton.cornerRad()
        dragebtn.cornerRad2()
        
//        backview.frame = (UIApplication.shared.keyWindow?.bounds)!
//        backview.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.503021816)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {



    }
    override func viewDidAppear(_ animated: Bool) {

        DispatchQueue.main.async {
            self.popUpView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
            self.popUpView.frame.origin.y = (UIApplication.shared.keyWindow?.frame.height)! - self.popUpView.frame.height
        }
        let sta =  UIViewX()
        sta.frame = (UIApplication.shared.statusBarView?.bounds)!
        sta.firstColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.secondColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.horizontalGradient = false
        UIApplication.shared.keyWindow?.addSubview(sta)
        UIApplication.shared.statusBarStyle = .lightContent
        
        topView.frame.origin.y = (UIApplication.shared.statusBarView?.frame.height)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bgType(_ sender: Any) {

        self.removeOtherView();


        DispatchQueue.main.async {
            self.bgType.frame = CGRect(x: 0, y: 0, width: self.bloodgroupView.frame.width, height: 0)
            self.bloodgroupView.addSubview(self.bgType)
            UIView.animate(withDuration: 0.5, animations: {
                self.bloodgroupView.layer.borderColor  = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
                self.bgType.frame = CGRect(x: 0, y: 0, width: self.bloodgroupView.frame.width, height: self.bloodgroupView.frame.height)
            }) { (true) in

            }
        }


        
    }
 
    @IBAction func selectAge(_ sender: Any) {

           self.removeOtherView();

         DispatchQueue.main.async {
            self.pickerViewx.frame = CGRect(x: 0, y: (UIApplication.shared.keyWindow?.frame.height)! - ((UIApplication.shared.keyWindow?.frame.height)! / 4), width: (UIApplication.shared.keyWindow?.frame.width)!, height: (UIApplication.shared.keyWindow?.frame.height)! / 4)
        UIApplication.shared.keyWindow?.addSubview(self.pickerViewx)
            print(self.pickerView1.date)


        }
    }
    
    @IBAction func apve(_ sender: Any) {

         self.view.endEditing(true)

        bgTypeDropDown(text: "Male")
        
    }
    @IBAction func anve(_ sender: Any) {



        bgTypeLabel.text = "Female"
        bgType.removeFromSuperview()
        
    }

    
    func bgTypeDropDown(text: String) {
        bgTypeLabel.text = text
        bg = text
        bgTypeLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        bgType.removeFromSuperview()
        
    }
    @IBAction func maritalStatus(_ sender: Any) {
        
        self.maritalstatusSubView.frame = CGRect(x: 0, y: 0, width: self.maritalstatusView.frame.width, height: 0)
        maritalstatusView.addSubview(maritalstatusSubView)
        UIView.animate(withDuration: 0.5, animations: {
            self.maritalstatusView.layer.borderColor  = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
            self.maritalstatusSubView.frame = CGRect(x: 0, y: 0, width: self.maritalstatusView.frame.width, height: self.maritalstatusView.frame.height)
        }) { (true) in
            
        }
        
    }
    @IBAction func single(_ sender: Any) {
        maritalStatus(text: "Single")
        self.gender = "Single"
    }
    @IBAction func married(_ sender: Any) {
        maritalStatus(text: "Married")
        self.gender = "Married"
    }
    
    func maritalStatus(text: String) {
        statusLabel.text = text
        statusLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        maritalstatusSubView.removeFromSuperview()
        
    }
    
    
    @IBAction func continueAction(_ sender: Any) {

        guard let text = bgTypeLabel.text, !text.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let agetext = ageTextfield.text, !agetext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let phonetext = phone.text, !phonetext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let countrytext = countryLabel.text, !countrytext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let statetext = stateLabel.text, !statetext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let citytext = city.text, !citytext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let addresstext = address.text, !addresstext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let statusLabeltext = statusLabel.text, !statusLabeltext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        //workContact
        guard let workContacttext = workContact.text, !workContacttext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        guard let workAddresstext = workAddress.text, !workAddresstext.isEmpty else {
            APIManager.showAlertView(message: "Please complete form to continue")
            return
        }
        // contine to login as we have full data available
        basicProfile()

    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arraydata.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arraydata[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if type == Type1.country {
            countryLabel.text = arraydata[row]
            countryLabel.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            contyView.layer.borderColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        }else {
            stateLabel.text = arraydata[row]
            stateLabel.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
            stateView.layer.borderColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        }
        print(arraydata[row])
    }
    
    @IBAction func done(_ sender: Any) {

        DispatchQueue.main.async {
            self.popUpView.removeFromSuperview()
            self.backview.removeFromSuperview()
        }

    }
    
    @IBAction func country(_ sender: Any) {
        arraydata = data1
        type = Type1.country
        pickerView.reloadAllComponents()
        UIApplication.shared.keyWindow?.addSubview(backview)
        UIApplication.shared.keyWindow?.addSubview(popUpView)
    }
    @IBAction func state(_ sender: Any) {
        arraydata = data
        type = Type1.state
        pickerView.reloadAllComponents()
        UIApplication.shared.keyWindow?.addSubview(backview)
        UIApplication.shared.keyWindow?.addSubview(popUpView)
    }
    

    
    
    func basicProfile() {

        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/profile/update_doctor_profile")
        guard let serviceUrl = URL(string: Url) else { return }
        
                if bgTypeLabel.text != "" && ageTextfield.text != "" && phone.text != "" && countryLabel.text != "" && stateLabel.text != "" && city.text != "" && address.text != ""  && statusLabel.text != "" && workContact.text != "" && workAddress.text != "" {
        let parameterDictionary = [
            "email":APIManager.sharedInstance.getLoggedInUser()?.email,
            "gender":"\(bgTypeLabel.text!)",
            "dob":"\(ageTextfield.text!)",
            "contactno":"\(phone.text!)",
            "country":"\(countryLabel.text!)",
            "state":"\(stateLabel.text!)",
            "city":"\(city.text!)",
            "address":"\(address.text!)",
            "martialstatus":"\(statusLabel.text!)",
            "workno":"\(workContact.text!)",
            "workaddress":"\(workAddress.text!)"
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
                    APIManager.sharedInstance.showHud()
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
                        print(json)
                        DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "medicalhistory") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                        }
                    }
                    
                }catch {
                    print(error)
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Try again something is wronge.")
                    return
                }
            }
            }.resume()
                }else {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Fill all fields.")
        }
    }
    
    
    
    @IBAction func skipbtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "medicalhistory") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func donebtn(_ sender: Any) {
        pickerViewx.removeFromSuperview()
        
    }
    func dateChanged(_ sender: UIDatePicker) {
  
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ageTextfield.text = dateFormatter.string(from: pickerView1.date)
        ageTextfield.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
    }


    func removeOtherView() -> Void {
        DispatchQueue.main.async {
            self.popUpView.removeFromSuperview()
            self.backview.removeFromSuperview()
            self.pickerViewx.removeFromSuperview()
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.popUpView.removeFromSuperview()
            self.backview.removeFromSuperview()
            self.pickerViewx.removeFromSuperview()
            textField.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
        
    
        
        if textField == ageTextfield && textField.text != "" {
            let text = textField.text
            textField.text! = text!
            
        }
        if textField == heightTextfield && heightTextfield.text != "" {
            let text = textField.text
            textField.text! = text!
            self.weight = text!
        }
        if textField == workAddress && workAddress.text != "" {
            let text = textField.text
            textField.text! = text!
            self.height = text!
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ageTextfield {
            return false
        }else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

























