//
//  ViewController.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 11/09/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn
import Google
import Firebase
import FirebaseCore

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet var isdoctorView: UIView!
    @IBOutlet weak var topconstant: NSLayoutConstraint!
    
    let faceBooklogInButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.loginBehavior = .web
        return button
    }()
    
    @IBOutlet weak var emailTextfield: UITextfieldX!
    @IBOutlet weak var passwordTextfield: UITextfieldX!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var continueButton: UIButtonX!
    
//    @IBOutlet weak var shadowView: UIViewX!
    
    @IBOutlet weak var googleView: UIViewX!
    @IBOutlet weak var facebookView: UIViewX!
    
    @IBOutlet weak var loginView: UIViewX!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var viewHolder: UIView!
    
//    @IBOutlet weak var buttonholderView: UIView!\
    
    var googleId: String!
    var googleFname: String!
    var googleLname: String!
    var googleEmail: String!
    
    var viewframe: CGRect!
    var viewHolderframe: CGRect!
    var isFaceBook: Bool = false
    
    var container: ContainerViewController!
    
    var height: CGFloat!
    var width: CGFloat!
    var x: CGFloat!
    var y: CGFloat!
    
    var googlefram: CGRect!
    var facebookfram: CGRect!
    var togle: Type1!
    
    
    enum `Type1` {
        case signIn
        case signUP
    }
    
    var value: Bool = true
    @IBOutlet weak var isdoctorBtn: UIButton!
    @IBOutlet weak var ispatientBtn: UIButton!
    @IBOutlet weak var backgrountView: UIViewX!
    
    
    
    
    
    @IBAction func isDoctor(_ sender: Any) {
        selectedButtonImage(cirle: isdoctorBtn, circle2: ispatientBtn)
        self.value = true
        closePopUp(googleId: self.googleId, fname: self.googleFname, lname: self.googleLname, email: self.googleEmail, value: self.value)
        
    }
    
    @IBAction func isPatient(_ sender: Any) {
        selectedButtonImage(cirle: ispatientBtn, circle2: isdoctorBtn)
        self.value = false
        closePopUp(googleId: self.googleId, fname: self.googleFname, lname: self.googleLname, email: self.googleEmail, value: self.value)
    }
    
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgrountView.layer.cornerRadius = 8
        backgrountView.clipsToBounds = true

        GIDSignIn.sharedInstance().signOut()
        FBSDKLoginManager().logOut()
//
        self.emailTextfield.layer.cornerRadius = self.emailTextfield.frame.height / 2
        self.passwordTextfield.layer.cornerRadius = self.passwordTextfield.frame.height / 2
        self.continueButton.layer.cornerRadius = self.continueButton.frame.height / 2

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bgImage")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
        DispatchQueue.main.async {
            var error: NSError?
            GGLContext.sharedInstance().configureWithError(&error)
            if error != nil {
                                
                return
            }

        }

        
        
//
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 34 - 4  , y: 100, width: self.view.frame.width - 60, height: 300))
//        signInButton.backgroundColor = #colorLiteral(red: 0.1506797969, green: 0.8162507415, blue: 0.6714989543, alpha: 1)
        signInButton.colorScheme = .dark
        signInButton.style = .wide
        signInButton.layer.backgroundColor = #colorLiteral(red: 0.1506797969, green: 0.8162507415, blue: 0.6714989543, alpha: 1).cgColor
//        signInButton.superview?.backgroundColor = #colorLiteral(red: 0.9966978431, green: 0.5666350722, blue: 0, alpha: 1)
//        view.addSubview(faceBooklogInButton)
        faceBooklogInButton.delegate = self
        
//        view.addSubview(signInButton)
        faceBooklogInButton.frame = CGRect(x: 34, y: signInButton.center.y - 66, width: self.view.frame.width - 66, height: 40)

    }

    override func viewWillAppear(_ animated: Bool) {
       
        
        if(APIManager.sharedInstance.getLoggedInUser() != nil){

//
//        SKSocketConnection.socketSharedConnection.connectSocket(userId: (APIManager.sharedInstance.getLoggedInUser()?.id!)! , sessionId: APIManager.sharedInstance.randomString(length: 8))
            
            if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Doctor") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
                
                
            }else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
         togle = Type1.signUP
        
        
        
//        self.viewHolder.layer.cornerRadius = self.viewHolder.frame.height / 19
//        self.shadowView.layer.cornerRadius = self.shadowView.frame.height / 19
    
//
//            googlefram = self.googleView.frame
//            facebookfram = self.facebookView.frame
        
//        buttonholderView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.width / 5)
       
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        self.googleView.layer.cornerRadius = self.googleView.frame.height / 1.9
        self.facebookView.layer.cornerRadius = self.facebookView.frame.height / 1.9
        
        let sta =  UIViewX()
        sta.frame = (UIApplication.shared.statusBarView?.bounds)!
        sta.firstColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.secondColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.horizontalGradient = false
        UIApplication.shared.keyWindow?.addSubview(sta)
        UIApplication.shared.statusBarStyle = .lightContent
        
        topconstant.constant = (UIApplication.shared.statusBarView?.frame.height)!
    }
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if error != nil {
//            print(error)
//            return
//        }
//        
//        let userId = user.userID                  // For client-side use only!
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let email = user.profile.email
//        
//        print("\n\n",userId!,"\n\n",fullName!,"\n\n",givenName!,"\n\n",email!,"\n\n")
//        
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singIn(_ sender: Any) {
        
        self.togle = Type1.signUP
        
        UIView.animate(withDuration: 0.3, animations: {
//            self.viewHolder.frame = self.viewHolderframe
//            self.viewHolder.center = self.view.center
//            self.buttonholderView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.width / 5)
//            self.shadowView.frame = self.viewHolder.frame
        }) { (true) in
        }
        
        UIView.animate(withDuration: 0.2) {
//             self.googleView.frame = self.googlefram
//            self.facebookView.frame = self.facebookfram
            self.signInButton.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            self.signInButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.signUpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.signUpButton.setTitleColor(#colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1), for: .normal)
        }
      
        
        container!.segueIdentifierReceivedFromParent("LogIn")
//        self.viewHolder.center = self.view.center

        
       
    }
    @IBAction func signOut(_ sender: Any) {
        
//        let aheight = self.viewHolder.frame.height
//        let awidth = self.viewHolder.frame.width
//        let ax = self.viewHolder.frame.origin.x
//        let ay = self.viewHolder.frame.origin.y
//
        if self.togle == Type1.signUP {
            UIView.animate(withDuration: 0.3, animations: {
//                self.viewHolder.frame = CGRect(x: ax, y: ay, width: awidth, height: aheight + 60)
//                self.viewHolder.center = self.view.center
//                self.shadowView.frame = self.viewHolder.frame
                
            }) { (true) in
                
            }
            
            
            
            UIView.animate(withDuration: 0.2) {
                
//                self.googleView.frame = self.googlefram
//                self.facebookView.frame = self.facebookfram
                self.signInButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.signInButton.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
                self.signUpButton.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
                self.signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            }
            

            container!.segueIdentifierReceivedFromParent("SignUp")
            
            
        }
        
        self.togle = Type1.signIn
       }
    

    @IBAction func googleButton(_ sender: Any) {
        DispatchQueue.main.async(execute: {
            GIDSignIn.sharedInstance().signIn()
        })
    }

    @IBAction func logout(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        FBSDKLoginManager().logOut()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
        }
    }

    @IBAction func fbLogIn(_ sender: Any) {
        faceBooklogInButton.sendActions(for: .touchUpInside)
    }
    
    //MARK:Google SignIn Delegate
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard let error = error else {
            var userId = ""                // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            var fullName = ""
            var fname = ""
            var lname = ""
            var givenName = ""
            var email = ""
            if let useID = user.userID {
                userId = useID
            }
            if let full = user.profile.name {
                fullName = full
            }
            if let givenName = user.profile.givenName {
                fname = givenName
            }
            if let lastname = user.profile.familyName {
                lname = lastname
            }
            if let lastname = user.profile.name {
                givenName = lastname
            }
            if let emailStr = user.profile.email {
                email = emailStr
            }
            guard email.count > 0 else {
                APIManager.showAlertView(message: "Unable to get user email ID, Please allow email access permission to login with google");
                return;
            }
            
            self.isFaceBook = false
            self.googleId = userId
            self.googleFname = fname
            self.googleLname = lname
            self.googleEmail = email
            signInWithGoogle(googleId: googleId, fname: fname, lname: lname, email: email, value: value)
//            isDrPatPopup()
            print("\n\n",userId,"\n\n",fullName,"\n\n",givenName,"\n\n",email,"\n\n")
            return
        }
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            APIManager.showAlertView(message: "\(error.localizedDescription)");
        }
         print("\(error.localizedDescription)")
    }
    
    
    
    
    // MARK : - FACEBOOK LOGIN DELEGATE IMPLEMENTATION.
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        
        print("\nLogIn func\n")
        //        fetchProfile()
        return true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("\nCompleted login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
        
        let manager = FBSDKLoginManager()
        manager.logOut()
        print(" facebook Loged out")
    }
    
    
    
    
    func isDrPatPopup() -> Void {
        DispatchQueue.main.async {
            self.isdoctorView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(self.isdoctorView);
            UIView.animate(withDuration: 0.15, animations: {
                self.isdoctorView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) { (compelte) in
            }
        }
    }
    
//    
    func closePopUp(googleId: String , fname: String, lname: String, email: String ,value: Bool)  {
        
        if value {
            //Doctor side..
            if self.isFaceBook {
                self.signUpWithFacebookDoctor(firstname: fname, lastname: lname, email: email, googleId: googleId)
            }else {
                self.signUpWithGoogleDoctor(firstname: fname, lastname: lname, email: email, googleId: googleId)
            }
        } else {
            //Patient Side..
            if self.isFaceBook {
                self.signUpWithFacebook(firstname: fname, lastname: lname, email: email, googleId: googleId)
            }else {
                self.signUpWithGoogle(firstname: fname, lastname: lname, email: email, googleId: googleId)
            }
        }
        
//        signInWithGoogle(googleId: googleId, fname: fname, lname: lname, email: email, value: value)
        self.isdoctorView.removeFromSuperview()
    }
//
    
    func fetchProfile() {
        
        print("\nfetch profile\n")
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, first_name, last_name, id, gender, link"])
            .start(completionHandler:  {
                (connection, result, error) in
                guard
                    let result = result as? NSDictionary,
                    let email = result["email"] as? String,
                    let username = result["first_name"] as? String,
                    let lname = result["last_name"] as? String,
                    let user_gender = result["gender"] as? String,
                    let user_id_fb = result["id"]  as? String,
                    let user_id_fb_photo = result["link"]  as? String
                    else {return}
                
                print("\n\n",email)
                print(username)
                print(user_gender)
                print(user_id_fb,"\n\n")
                
                self.isFaceBook = true
                
                self.googleId = user_id_fb
                self.googleFname = username
                self.googleLname = lname
                self.googleEmail = email
                self.signInWithGoogle(googleId: self.googleId, fname: self.googleFname, lname: self.googleLname, email: self.googleEmail, value: self.value)

//                self.isDrPatPopup()
                
                
            })
    }
    
    
    
//Login with google / facebook service calling..
    func signInWithGoogle(googleId: String,fname: String, lname: String , email: String, value: Bool)  {
        var url: String!
        var dict = [String : AnyObject]()
    
        if isFaceBook {
            url = SIGNIN_WITH_FACEBOOK
            dict = [  "facebookid"        : googleId
                ] as [String : AnyObject]
            
        }else {
             url = SIGNIN_WITH_GOOGLE
            dict = [  "googleid"        : googleId
                ] as [String : AnyObject]
            
        }
   
        
        WebServiceManager.post(params: dict, serviceName: url, serviceType: "SIGNIN WITH GOOGLE" , modelType: GetAllDoctorSlot.self, success: { (response) in

            let res = response as! GetAllDoctorSlot
            if res.success == true {
                if let userInfoData = res.user {
                    if let user: SKUser = SKUser(JSON: userInfoData) {
                        debugPrint(user.name);
                        APIManager.sharedInstance.saveLoggedInUser(user: user);
                        if(user.isDoctor)!{
                            // User is doctor
                            DispatchQueue.main.async(execute: {
                                let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "Doctor") as UIViewController
                                self.present(vc, animated: true, completion: nil)
                                //social media login
                                APIManager.sharedInstance.isSocial(social: true)
                            })
                        }else{
                            // User is patient
                            DispatchQueue.main.async(execute: {
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
                                    self.present(vc, animated: true, completion: nil)
                                    //social media login
                                    APIManager.sharedInstance.isSocial(social: true)
                                }
                            })
                        }
                    }
                }
            }else {
                self.isDrPatPopup()
            }
        }, fail: { (error) in
        }, showHUD: true)
    }
    
// - Mark : - SignUp with google sevice calling
    func signUpWithGoogle(firstname: String,lastname: String, email : String ,googleId :String)  {
        let idofAppointmet = [  "googleid"        : googleId,
                                "firstname"         : firstname,
                                "lastname"          : lastname,
                                "email"             : email,
                                
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: SIGNUP_WITH_GOOGLE, serviceType: "SIGNIN WITH GOOGLE AS A PATIENT" , modelType: GetAllDoctorSlot.self, success: { (response) in
            
            let res = response as! GetAllDoctorSlot
            if res.success == true {
                if let userInfoData = res.user {
                    if let user: SKUser = SKUser(JSON: userInfoData) {
                        debugPrint(user.name);
                        APIManager.sharedInstance.saveLoggedInUser(user: user);
                            DispatchQueue.main.async(execute: {
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "genderSelection") as UIViewController
                                    self.present(vc, animated: true, completion: nil)
                                    //social media login
                                    APIManager.sharedInstance.isSocial(social: true)
                            }
                        })
                    }
                }
            }else {
                if res.message != nil {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: res.message!)
                }
            }
            
            
        }, fail: { (error) in
        }, showHUD: true)
    }
    
    
    
    
    // - Mark : - SignUP with google as a doctor service calling
    func signUpWithGoogleDoctor(firstname: String,lastname: String, email : String ,googleId :String)  {
        let idofAppointmet = [  "googleid"        : googleId,
                                "firstname"         : firstname,
                                "lastname"          : lastname,
                                "email"             : email,
                                
                                ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: SIGNIN_WITH_GOOGLE_AS_A_DOCTOR, serviceType: "SIGNIN WITH GOOGLE AS A DOCTOR" , modelType: GetAllDoctorSlot.self, success: { (response) in
            
            let res = response as! GetAllDoctorSlot
            if res.success == true {
                if let userInfoData = res.user {
                    if let user: SKUser = SKUser(JSON: userInfoData) {
                        debugPrint(user.name);
                        APIManager.sharedInstance.saveLoggedInUser(user: user);

                        if(user.isDoctor)!{
                            DispatchQueue.main.async(execute: {
                                let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "doctorBasicProfile") as UIViewController
                                self.present(vc, animated: true, completion: nil)
                                //social media login
                                APIManager.sharedInstance.isSocial(social: true)
                            })

                        }
                    }
                }
            }else {
                if res.message != nil {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: res.message!)
                }
            }
            
            
        }, fail: { (error) in
        }, showHUD: true)
    }
    
    
    

    // -Mark : - SIGN UP WITH FACEBOOOK AS PATIENT.
    
    func signUpWithFacebook(firstname: String,lastname: String, email : String ,googleId :String)  {
        let idofAppointmet = [  "facebookid"        : googleId,
                                "firstname"         : firstname,
                                "lastname"          : lastname,
                                "email"             : email,
                                
                                ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: SIGNUP_WITH_FACRBOOK_AS_A_PATIENT, serviceType: "SIGNIN WITH FACEBOOK AS A Patient" , modelType: GetAllDoctorSlot.self, success: { (response) in
            
            let res = response as! GetAllDoctorSlot
            if res.success == true {
                if let userInfoData = res.user {
                    if let user: SKUser = SKUser(JSON: userInfoData) {
                        debugPrint(user.name);
                        APIManager.sharedInstance.saveLoggedInUser(user: user);
                        DispatchQueue.main.async(execute: {
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "genderSelection") as UIViewController
                                self.present(vc, animated: true, completion: nil)
                                //social media login
                                APIManager.sharedInstance.isSocial(social: true)
                            }
                        })
                    }
                }
            }else {
                if res.message != nil {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: res.message!)
                }
                
                
            }
            
            
        }, fail: { (error) in
            print(error)
        }, showHUD: true)
    }
    
    
    
    
    func signUpWithFacebookDoctor(firstname: String,lastname: String, email : String ,googleId :String)  {
        let idofAppointmet = [  "facebookid"        : googleId,
                                "firstname"         : firstname,
                                "lastname"          : lastname,
                                "email"             : email,
                                
                                ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: SIGNUP_WITH_FACRBOOK_AS_A_PATIENT, serviceType: "SIGNIN WITH FACEBOOK AS A DOCTOR" , modelType: GetAllDoctorSlot.self, success: { (response) in
            
            let res = response as! GetAllDoctorSlot
            if res.success == true {
                if let userInfoData = res.user {
                    if let user: SKUser = SKUser(JSON: userInfoData) {
                        debugPrint(user.name);
                        APIManager.sharedInstance.saveLoggedInUser(user: user);
                    
                        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "doctorBasicProfile") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                        //social media login
                        APIManager.sharedInstance.isSocial(social: true)
                
                    }
                }
            }else {
                if res.message != nil {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: res.message!)
                }
                
            }
            
            
        }, fail: { (error) in
        }, showHUD: true)
    }


    @IBAction func forgotPassword(_ sender: Any) {

      

    }

    func forgetPassCall(emailid : String ) -> Void {

        let jsonUrlString = APIManager.sharedInstance.baseUrl+"/api/MobileApp/session/" + "forget_password"

        APIManager.GET(url: jsonUrlString, parameters: ["email" : emailid as AnyObject]) { (response, json) in

APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Please check your emailid to reset Password")

        }

    }


}

















