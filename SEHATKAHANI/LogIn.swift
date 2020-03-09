//
//  LogIn.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 29/09/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//


import UIKit

class LogIn: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.delegate = self
        passwordText.delegate = self
        
        emailText.padding(value: 15)
        passwordText.padding(value: 15)
    
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {

        UIView.animate(withDuration: 0.5) {
            self.emailText.alpha = 1
            self.passwordText.alpha  = 1
            self.continueButton.alpha = 1
        }
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func viewDidLayoutSubviews() {
        emailText.textcor()
        passwordText.textcor()
        continueButton.cornerRad()
    }
    override func viewWillDisappear(_ animated: Bool) {
//
//        emailText.layer.cornerRadius = emailText.frame.height / 1.9
//        passwordText.layer.cornerRadius = emailText.frame.height / 1.9
        UIView.animate(withDuration: 1.0) {
            self.emailText.alpha = 0
            self.passwordText.alpha  = 0
            self.continueButton.alpha = 0

        }
        
    }
    @IBAction func logIn(_ sender: Any) {
        signin()
        APIManager.sharedInstance.isSocial(social: false)
    }
    
    
    func signin() {
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/mobile_user_signin")
        guard let serviceUrl = URL(string: Url) else { return }
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "apns_Token")
        
        if name == nil {
            DEVICE_TOKEN = "sdfasdfasdf"
        } else {
            DEVICE_TOKEN = defaults.string(forKey: "apns_Token")!
        }
        if emailText.text != "" && passwordText.text != "" {
            let parameterDictionary = [
                "email":"\(emailText.text!)",
                "password":"\(passwordText.text!)" ,
                "deviceToken" : DEVICE_TOKEN
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
                    print(error!)
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
                            if let message = json["user"] as? NSDictionary{
                                DispatchQueue.main.async {
                                    self.emailText.text = ""
                                    self.passwordText.text = ""
                                }
                                if let userInfoData = message as? [String : AnyObject] {
                                    
                                    
                                    if let id = message["_id"] as? String {
                                        print("\n\n\n",id)
                                        APIManager.sharedInstance.setToken(token: id)

                                        APIManager.sharedInstance.setId(id: id)
                                        
                                    }
                                    if let emailOfUser = message["email"] as? String {
                                        
                                        
                                        APIManager.sharedInstance.setEmail(email:emailOfUser)
                                        print("\n\n\n",emailOfUser)
                                    }
                                    if let email = message["_id"] as? String {
                                        print("\n\n\n",email)
                                    }
                                    if let token = message["_id"] as? String {
                                        print("\n\n\n",token)
                                    }
                                        if let user: SKUser = SKUser(JSON: userInfoData) {
                                        debugPrint(user.name);
                                    APIManager.sharedInstance.saveLoggedInUser(user: user);
                                    
                                    if(user.isDoctor)!{
                                        DispatchQueue.main.async(execute: {
                                            let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
                                            let vc = storyboard.instantiateViewController(withIdentifier: "Doctor") as UIViewController
                                            self.present(vc, animated: true, completion: nil)
                                        })
                                        
                                    }else{
                                        
                                        DispatchQueue.main.async(execute: {
                                            DispatchQueue.main.async {
                                                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                                                let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                            }
                                            
                                            
                                        })  
                                    }
                                }
                            }
                            }else {
                                if let message = json["message"] as? String{
                                APIManager.sharedInstance.customAlert(viewcontroller: self, message: message)
                                
                                }
                            }
                        }
                        
                    }catch {
                        print(error)
                        return
                    }
                }
                }.resume()
        }else {
            //            activityIndicator.stopAnimating()
            //            fields.forEach { word in
            //                if word.text == "" {
            //                    word.rightPad(value: 0, color: #colorLiteral(red: 0.3411764706, green: 0.7490196078, blue: 0.4705882353, alpha: 1))
            //                }
            //
            //            }
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailText {
            if !((emailText.text?.isValidEmail())!) {
                APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Invalid email address.!")
                emailText.text = ""
            }
        }
        textField.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func forgotAction(_ sender: Any) {


        let alertController = UIAlertController(title: "Forgot Password", message: "Please enter your email id", preferredStyle: UIAlertControllerStyle.alert)

        let saveAction = UIAlertAction(title: "Recover Password", style: .cancel, handler: {
            alert -> Void in

            let firstTextField = alertController.textFields![0] as UITextField
            self.forgetPassCall(emailid: firstTextField.text ?? "");
        })

        let cancelAction = UIAlertAction(title: "Cancel", style:.destructive, handler: {
            (action : UIAlertAction!) -> Void in

        })

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter your email id"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        if let vc = UIApplication.topViewController(){
            vc.present(alertController, animated: true, completion: nil)
        }




    }


    func forgetPassCall(emailid : String ) -> Void {

        let jsonUrlString = APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/" + "forget_password"

        APIManager.POST(url: jsonUrlString, parameters: ["email" : emailid as AnyObject]) { (response, json) in


            if let jsonDict = json?.dictionaryObject {
                let message = jsonDict["message"] as? String

                if message != nil {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: message!)
                    return;
                }


            }


            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Please check your emailid to reset Password")




        }

    }
    

}











