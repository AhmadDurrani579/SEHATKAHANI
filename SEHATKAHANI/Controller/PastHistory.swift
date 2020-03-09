//
//  PastHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 13/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PastHistory: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var popup: UIView!
    
    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet weak var pastHistoryView: AnimatedView!
    @IBOutlet var scrollpopup: UIScrollView!
    @IBOutlet weak var doselabel: UILabel!
    @IBOutlet weak var additCommentTextfield: UITextField!
    @IBOutlet weak var drugnamelabel: UILabel!
    @IBOutlet weak var drugnameTextfield: UITextField!
    @IBOutlet weak var additCommlabel: UILabel!
    @IBOutlet weak var addbutton: ViewHolder!
     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addmoreView: UIViewX!
    
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var drView: UIView!
    @IBOutlet weak var drqualificationField: UITextField!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet var dropDownView: UIView!
    @IBOutlet weak var dropdButtonOutlet: UIButton!
    @IBOutlet weak var typeOfDisease: UILabel!
    @IBOutlet weak var dropDownTableView: UITableView!
    
    var parameterDictionary = [String: Any]()
    
    var takingMedicine = true
    var diseasetype = ""
    
    let array = ["Abdominal Aortic Aneurysm",
                 "Acanthamoeba Infection",
                 "ACE",
                 "Acinetobacter Infection",
                 "Acquired Immune Deficiency Syndrome",
                 "Acquired Immunodeficiency Syndrome",
                 "Adenovirus Infection",
                 "Adenovirus Vaccination"]
    
    let window = UIApplication.shared.keyWindow!
    var dose: Int!
    var myNewView: UIButton!
    var fr: CGRect!
    let
    
    blackView = BlackAndPopUPViews()
    
    var allMedication: FamilyHis?
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
    var fra: CGRect!
    
    let medicationCard = PastHistoryMedication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            cardTitle.text = "Qualification"
        }else {
            cardTitle.text = "Past History"
        }
        
        
        tableView.isHidden = true
        addmoreView.isHidden = true
        drqualificationField.delegate = self
        
        popup.xView(value: 10)
        dose = 1
        doselabel.text = "\(dose!)"
        additCommentTextfield.delegate = self
        drugnameTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func downGesture(_ sender: Any) {
        blackView.close(popView: popup)
    }
    override func viewWillAppear(_ animated: Bool) {
         pastHistoryView.animation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addNew(_ sender: Any) {
        
      if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
           drView.isHidden = false
        }else {
            drView.isHidden = true
        }
        
        blackView.BlackPopup(popView: popup, addButton: addbutton)
       

    }
    

    @IBAction func decrButton(_ sender: Any) {
        if dose > 1 {
            dose = dose - 1
            doselabel.text = "\(dose!)"
        }
    }
    @IBAction func increButton(_ sender: Any) {
        dose = dose + 1
        doselabel.text = "\(dose!)"
    }
    @IBAction func addButton(_ sender: Any) {
        medication()
       
    }
    func closePopUp() {
        blackView.close(popView: popup)
    }
    @IBAction func addMoreMedication(_ sender: Any) {
         blackView.BlackPopup(popView: popup, addButton: addbutton)
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableView == dropDownTableView {
            return array.count
        }else {
          return allMedication?.result.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  tableView == dropDownTableView {
            let cell2 = dropDownTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
            cell2.typelabel.text = array[indexPath.row]
            return cell2
        }else {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = allMedication?.result[indexPath.row].Disease
             return cell1
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dropDownTableView {
            self.diseasetype = array[indexPath.row]
            self.typeOfDisease.text = self.diseasetype
        }
        dropDownView.removeFromSuperview()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/
    
    func medication() {
        if let userid  = APIManager.sharedInstance.getLoggedInUser()?.id {
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
            
            self.parameterDictionary = [
                "email": APIManager.sharedInstance.getLoggedInUser()?.email,
                "degree":"\(drqualificationField.text!)"
            ]
            medicationCard.drCard(parameterDictionary: parameterDictionary, url: "/api/MobileApp/profile/update_doctor_qualification")
             self.blackView.close(popView: self.popup)
//             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)
            
        }else {
            
            
            
            if takingMedicine == true {
                self.parameterDictionary = [
                    "id":APIManager.sharedInstance.getLoggedInUser()!.id!,
                    "Disease":"\(self.diseasetype)",
                    "Treatment": true
                ]
                
            }
            if takingMedicine == false {
                self.parameterDictionary = [
                    "id":APIManager.sharedInstance.getLoggedInUser()!.id!,
                    "Disease":"\(self.diseasetype)",
                      "Treatment": false
                ]
            }
            
            
            medicationCard.addMedicationHistory(parameterDictionary: parameterDictionary) { (medication) in
                DispatchQueue.main.async {
                    self.medicationCard.allMedication(parameterDictionary: ["id" : userid], completion: { (allMedication) in
                        DispatchQueue.main.async {
                            self.tableView.isHidden = false
                            self.addmoreView.isHidden = false
                            self.allMedication = allMedication
                            self.tableView.reloadData()
//                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nextCall"), object:nil, userInfo:nil)

                        }
                    })
                    self.blackView.close(popView: self.popup)
                }
            }

        }
        
    }
    }
    
    
    
    func abc() {
        self.blackView.close(popView: self.popup)
    }
    
    
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                if textField == self.additCommentTextfield {
                    self.viewMoveUp(popUpView: self.popup, value: self.additCommentTextfield)
                    self.additCommlabel.backgroundColor  =  #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
                } else {
                    self.viewMoveUp(popUpView: self.popup, value: self.drugnameTextfield)
                    self.drugnamelabel.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
                }
            }
        }
        
       
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == additCommentTextfield {
            additCommlabel.backgroundColor  =  #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }else {
            drugnamelabel.backgroundColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.3) {
        self.popup.frame = self.fra
        }
        gesture.isEnabled = true
        textField.resignFirstResponder()
        return true
    }


    
    
    @IBAction func yesButton(_ sender: Any) {
        selectedButtonImage(cirle: yesButton, circle2: noButton)
        self.takingMedicine = true
    }
    @IBAction func noButton(_ sender: Any) {
        self.takingMedicine = false
        selectedButtonImage(cirle: noButton, circle2: yesButton)
    }
    func selectedButtonImage(cirle: UIButton, circle2: UIButton) {
        cirle.setImage(UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        circle2.setImage(UIImage(named: "circle-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    
    @IBAction func dropDown(_ sender: Any) {
        
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        dropDownTableView.reloadData()
        
        self.dropDownView.frame = CGRect(x: self.dropdButtonOutlet.frame.origin.x, y: self.dropdButtonOutlet.frame.origin.y + self.dropdButtonOutlet.frame.height , width: self.dropdButtonOutlet.frame.width, height: 150)
        self.popup.addSubview(self.dropDownView)
        self.dropDownView.addSubview(self.dropDownTableView)
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.dropDownView.frame = CGRect(x: self.dropdButtonOutlet.frame.origin.x, y: self.dropdButtonOutlet.frame.origin.y + self.dropdButtonOutlet.frame.height, width: self.dropdButtonOutlet.frame.width, height: self.dropdButtonOutlet.frame.height * 5)
//            self.tableView.frame = self.dropDownView.bounds
//        }) { (true) in
//        }
        
        
    }
    
    
    
    
    func viewMoveUp(popUpView: UIView, value: UITextField) {
        gesture.isEnabled = false
        self.fra = popUpView.frame

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

















