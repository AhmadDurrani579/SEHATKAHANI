//
//  SurgicalHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SurgicalHistory: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet weak var surgerylabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var surgeryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var sugeryTextfield: UITextField!
    
    @IBOutlet weak var surgeryView: AnimatedView!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var reasonlabel: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var surgicalTableView: UITableView!
    @IBOutlet weak var addMoreView: UIViewX!
    
    @IBOutlet var popUpView: ViewHolder!
    @IBOutlet var viewForTable: UIView!
    let blackView = BlackAndPopUPViews()
    var fra: CGRect!
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet var pickerforView: UIViewX!
    
    @IBOutlet weak var drView: UIView!
    @IBOutlet weak var drHostpitalField: UITextField!
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
    let backview = UIViewX()
    
    @IBOutlet weak var cardTitle: UILabel!
    let surgery = SurgicalModel()
    var surgicalData: AllSurgaries?
    
    var type = ""
    var reason = ""
    var dateofsurgery = ""
    
    @IBOutlet weak var reasonTextfield: UITextField!
    let array = ["Eyes (cataract)", "Eyes (Glaucoma)","Ear","Nose","Sinuses","Tonsils","Thyroid","Parathyroid glands ","Heart valves repair or replacement","Arrhythmia Treatment","Coronary artery bypass grafting (CABG)","Aneurysm Repair","Lungs","Esophagus","Stomach (ulcer)","Bowel (small & large intestine)","Appendix","Liver (including hepatitis)","Gallbladder","Spleen","Hernia","Kidney","Bladder","Bone fracture repair","Joint replacement surgery","Neck","Spine","Brain","Skin","Breasts","Uterus","Prostate","Penis/Scrotal Surgery","Dental surgery","Cosmetic or plastic surgery"]
    override func viewDidLoad() {
        super.viewDidLoad()

        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            cardTitle.text = "Hospitals"
        }else {
            cardTitle.text = "Surgical History"
        }
        
        surgicalTableView.isHidden = true
        addMoreView.isHidden = true
        
//        sugeryTextfield.delegate = self
        reasonTextfield.delegate = self
        drHostpitalField.delegate = self
        
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        surgeryView.animation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        
//        backview.frame = (UIApplication.shared.keyWindow?.bounds)!
//        backview.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        pickerforView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (UIApplication.shared.keyWindow?.frame.height)! / 3.5)
//        pickerforView.frame.origin.y = (UIApplication.shared.keyWindow?.frame.height)! - pickerforView.frame.height
//
//        UIApplication.shared.keyWindow?.addSubview(backview)
//        UIApplication.shared.keyWindow?.addSubview(popUpView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func surgeryData() {
        let uId = APIManager.sharedInstance.getLoggedInUser()!.id!
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{

            guard let text = drHostpitalField.text, !text.isEmpty else {
                APIManager.showAlertView(message: "Please complete the form to continue")
                return
            }


            let parameterDictionary = [
                "email": APIManager.sharedInstance.getLoggedInUser()?.email,
                "workplace": "\(drHostpitalField.text!)"
            ]
            let vc = PastHistoryMedication()
            vc.drCard(parameterDictionary: parameterDictionary, url: "/api/MobileApp/profile/update_doctor_work")
             self.blackView.close(popView: self.popUpView)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)
        }else {

            
            if surgerylabel.text! != "Type of surgery" {
                type = surgerylabel.text!
            }
         
            if date.text! != "Date" {
                self.dateofsurgery = date.text!
            }
            

            let parameterDictionary = [
                "id": uId,
                "Type":"\(self.type)",
                "Reason":"\(self.reasonTextfield.text!)",
                "dateofsurgery":"\(self.dateofsurgery)"
            ]
            
            surgery.addSurgeryData(parameterDictionary: parameterDictionary) { (response) in
                DispatchQueue.main.async {
                    self.surgery.allSurgeries(parameterDictionary: ["id" : uId], completion: { (allData) in
                        DispatchQueue.main.async {
                            self.surgicalTableView.isHidden = false
                            self.addMoreView.isHidden = false
                            self.surgicalData = allData
                            self.surgicalTableView.reloadData()

                        }
                    })

                    self.blackView.close(popView: self.popUpView)
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
    @IBAction func addMore(_ sender: Any) {
      
         blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    
    @IBAction func closePopUp(_ sender: Any) {
        blackView.close(popView: popUpView)
    }
    
    @IBAction func surgeryType(_ sender: Any) {
        
        self.viewForTable.frame = CGRect(x: self.surgeryButton.frame.origin.x, y: self.surgeryButton.frame.origin.y + self.surgeryButton.frame.height , width: self.surgeryButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.surgeryButton.frame.origin.x, y: self.surgeryButton.frame.origin.y + self.surgeryButton.frame.height, width: self.surgeryButton.frame.width, height: self.surgeryButton.frame.height * 5)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    @IBAction func add(_ sender: Any) {
        surgeryData()
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
        if tableView == surgicalTableView {
            return surgicalData?.result.count ?? 0
        }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == surgicalTableView {
            let cell1 = surgicalTableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = surgicalData?.result[indexPath.row].Reason
            return cell1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        surgerylabel.text = array[indexPath.row]
        self.type = array[indexPath.row]
        surgerylabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        viewForTable.removeFromSuperview()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                if textField == self.reasonTextfield {
                    
                    self.viewMoveUp(popUpView: self.popUpView, value: self.reasonTextfield)
                    self.reasonlabel.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
                }
//                if textField == self.sugeryTextfield {
//                    self.viewMoveUp(popUpView: self.popUpView, value: self.sugeryTextfield)
//                    self.datelabel.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
//                }
            }
        }
      
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == reasonTextfield {
            reasonlabel.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        }
//        if textField == sugeryTextfield {
//            datelabel.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.popUpView.frame = self.fra
        gesture.isEnabled = true
        textField.resignFirstResponder()
        return true
    }
    
    
    func moveView(View:UIView, up: Bool) {

    }
    
    @IBAction func dateButton(_ sender: Any) {
        
        pickerforView.frame = CGRect(x: 0, y: (UIApplication.shared.keyWindow?.frame.height)! - ((UIApplication.shared.keyWindow?.frame.height)! / 4), width: (UIApplication.shared.keyWindow?.frame.width)!, height: (UIApplication.shared.keyWindow?.frame.height)! / 4)
        UIApplication.shared.keyWindow?.addSubview(pickerforView)
        print(picker.date)
    }
    
    
    func dateChanged(_ sender: UIDatePicker) {
//        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
//        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
//            date.text = "\(year)-\(month)-\(day)"
//            date.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
//            print("\(year)-\(month)-\(day) ")
//        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date.text = dateFormatter.string(from: picker.date)
        self.dateofsurgery = dateFormatter.string(from: picker.date)
        date.textColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        pickerforView.removeFromSuperview()
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



































