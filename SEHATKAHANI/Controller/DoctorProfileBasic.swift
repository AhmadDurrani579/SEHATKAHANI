//
//  DoctorProfileBasic.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 01/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher
class DoctorProfileBasic:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {


    @IBOutlet weak var profileImage: UIImageView!
    //     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var savedVeiw: UIView!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var viewHolder: UIViewX!
    
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emergencyphoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var maritalButton: UIButton!
    @IBOutlet weak var bloodButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    
    @IBOutlet weak var lblFirstName: UILabel!

    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emgphoneLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var bloodGoupLabel: UILabel!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var email: UILabel!

    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var gerderView: UIViewX!
    
    @IBOutlet weak var blurBackground: UIVisualEffectView!
    
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView = UIVisualEffectView()
    
    var buttons = [UIButton]()
    var textfields = [UITextField]()
    
    var index = 0
    var userInfo: GetDoctorInfo?

    let array = [("Age","25 YEAR"),("Date of Birth","25 / 11 / 1990"),("Gender","MALE"),("Marital Status","Single"),("Email","ziaurrehman@alchemative.com"),("Phone Number","03210000007"),("Country","Pakistan"),("State","Sind"),("City","Lahore")]
    
    let bg = ["A+","A-","B+","B-","O+","O-"]
    let gender = ["Male","Female","Other"]
    let maritalStatus = ["Single","Married","Divorced","Widowed"]
    let country = ["Pakistan","India","Italy","Iraq","America","Angolo","Aruba"]
    let state = ["Punjab","Sind","KPK","Balochistan","Gilgit","Islamabad","Azad Kashmir"]
    
    var pickerData = [String]()
    var labelIdentity: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightField.delegate = self
        phoneField.delegate = self
        emergencyphoneField.delegate = self
        addressField.delegate = self
        cityField.delegate = self
        ageField.delegate = self
        heightField.delegate = self
        pickerView.delegate = self
        
        //        scrollView.frame.origin.y = (UIApplication.shared.statusBarView?.frame.height)!
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        DispatchQueue.main.async {
            self.scrollView.makeAwareOfKeyboard()
        }
        self.buttons = [genderButton,maritalButton,bloodButton,countryButton,stateButton]
        self.textfields = [ageField,heightField,weightField,phoneField,emergencyphoneField,addressField,cityField]
        
        viewHolder.roundCorners([.topLeft,.topRight], radius: 20)
        viewHolder.clipsToBounds = false
        
        savedButton.cornerRad()
        
        
        profileImage.cornerRadius1()
        
        let sta =  UIViewX()
        sta.frame = (UIApplication.shared.statusBarView?.bounds)!
        sta.firstColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.secondColor = #colorLiteral(red: 0.9804934731, green: 0.9804934731, blue: 0.9804934731, alpha: 1)
        sta.horizontalGradient = false
        UIApplication.shared.keyWindow?.addSubview(sta)
        UIApplication.shared.statusBarStyle = .lightContent
        
        blurBackground.frame = view.bounds
        
        self.scrollView.frame.size.width = self.view.frame.width
        print(self.view.frame.width ,"       -    ----     ", self.scrollView.frame.width,"       -    ----     ", self.viewHolder.frame.width)
        viewHolder.layer.cornerRadius = 20
        
        getDoctorPrfileInfo()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        //    automaticallyAdjustsScrollViewInsets = false
        
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        
        for fields in textfields {
            fields.isHidden = false
        }
        for button in buttons {
            button.isHidden = false
        }
        savedButton.isHidden = false
        //        scrollView.frame.size.height += 40
        
        
        ageField.text = ageLabel.text
        heightField.text = heightLabel.text
        weightField.text = weightLabel.text
        phoneField.text = phoneLabel.text
        emergencyphoneField.text = emgphoneLabel.text
        addressField.text = addressLabel.text
        cityField.text = cityLabel.text
        
    }
    @IBAction func savedButton(_ sender: Any) {
        
        ageLabel.text = ageField.text
        heightLabel.text = heightField.text
        weightLabel.text = weightField.text
        phoneLabel.text = phoneField.text
        emgphoneLabel.text = emergencyphoneField.text
        addressLabel.text = addressField.text
        cityLabel.text = cityField.text
        
        for fields in textfields {
            fields.isHidden = true
        }
        
        for button in buttons {
            button.isHidden = true
        }
        savedButton.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        
        //        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        //        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts) // Load the image centered
        //
        //        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        //        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        //        viewHolder.frame.size.width = self.view.frame.width - 40
        self.navigationController?.navigationBar.topItem?.title = "Edit Profile"
        let x = (view.frame.width - viewHolder.frame.width) / 2
        viewHolder.frame.origin.x = x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDoctorPrfileInfo() {
        let email = APIManager.sharedInstance.getLoggedInUser()?.email
        
        let idofAppointmet = [ "email"        : email
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETALLDOCTORPROFILE, serviceType: "Doctor Info" , modelType: GetDoctorInfo.self, success: { (response) in

            self.userInfo = (response as! GetDoctorInfo)
            self.ageField.text = self.userInfo?.userInfo?.dob
            self.genderLabel.text = self.userInfo?.userInfo?.gender
            self.maritalStatusLabel.text = self.userInfo?.userInfo?.martialstatus
            self.email.text = self.userInfo?.userInfo?.email
            self.phoneLabel.text = self.userInfo?.userInfo?.contactno
            self.countryLabel.text = self.userInfo?.userInfo?.country
            self.stateLabel.text = self.userInfo?.userInfo?.state
            self.cityLabel.text = self.userInfo?.userInfo?.city
            self.addressLabel.text = self.userInfo?.userInfo?.address
            if let url = self.userInfo?.userInfo?.patientPhotos?.secureUrl {
                let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
                self.profileImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                    
                    print((1 / totalSize) * 100)
                }, completionHandler: nil)
            }

            let firstName = self.userInfo?.userInfo?.name?.first
            let lastName = self.userInfo?.userInfo?.name?.last
            self.lblFirstName.text = "\(firstName!) \(lastName!)"

            

//
//            if  self.pendingAppointment?.success == true {
//                self.tableView.delegate = self
//                self.tableView.dataSource = self
//                self.tableView.reloadData()
//                self.tableView.estimatedRowHeight = 100
//                self.tableView.rowHeight = UITableViewAutomaticDimension
//
//
//            }else {
//            }
            
            
        }, fail: { (error) in
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "\(error)")
            
        }, showHUD: true)
        
        
    }
    
    
    @IBAction func selectGender(_ sender: Any) {
        pickerData = gender
        self.labelIdentity = "gender"
        pickerView.reloadAllComponents()
        blurView()
    }
    @IBAction func maritalStatus(_ sender: Any) {
        //        maritalStatus.frame = gerderView.bounds
        //        gerderView.addSubview(maritalStatus)
        //
        pickerData = maritalStatus
        self.labelIdentity = "maritalStatus"
        pickerView.reloadAllComponents()
        blurView()
    }
    @IBAction func BloodGroup(_ sender: Any) {
        pickerData = bg
        self.labelIdentity = "bg"
        pickerView.reloadAllComponents()
        blurView()
    }
    @IBAction func country(_ sender: Any) {
        pickerData = country
        self.labelIdentity = "country"
        pickerView.reloadAllComponents()
        blurView()
    }
    @IBAction func state(_ sender: Any) {
        pickerData = state
        self.labelIdentity = "state"
        pickerView.reloadAllComponents()
        blurView()
    }
    
    
    @IBAction func donePopup(_ sender: Any) {
        
        popUpView.removeFromSuperview()
        blurEffectView.removeFromSuperview()
    }
    
    
    func blurView()  {
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.6
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        let width = self.view.frame.width / 1.3
        popUpView.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.height / 4)
        popUpView.layer.cornerRadius = popUpView.frame.height / 10
        popUpView.layer.borderWidth = 2
        popUpView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popUpView.center = view.center
        view.addSubview(popUpView)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if labelIdentity == "bg" {
            bloodGoupLabel.text = pickerData[row]
        }
        if labelIdentity == "country" {
            countryLabel.text = pickerData[row]
        }
        if labelIdentity == "state" {
            stateLabel.text = pickerData[row]
        }
        if labelIdentity == "maritalStatus" {
            maritalStatusLabel.text = pickerData[row]
        }
        if labelIdentity == "gender" {
            genderLabel.text = pickerData[row]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }


}
