//
//  LifeStyleHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit


class LifeStyleHistory: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewForTable: UIView!
    @IBOutlet var popUpView: ViewHolder!
    @IBOutlet weak var typeofactivityButton: UIButton!
    @IBOutlet weak var textfieldLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet weak var LifeSHView: AnimatedView!
    @IBOutlet weak var lifeTableView: UITableView!
    @IBOutlet weak var addMoreView: UIViewX!
    
    var keyboardHeight = CGFloat()
    var keyboardFirstTime = true
     var fra: CGRect!
    var allActivities: AllPhysicalActivities?
    
    let array = ["Tobacco","Alcohol","Pan / Ghutka / Chalia?","Cigarettes?","Physical Activity","Other"]
    let blackView = BlackAndPopUPViews()
  
    var activities = PhysicalHistoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
        lifeTableView.isHidden = true
        addMoreView.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        LifeSHView.animation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func taped() {
        blackView.close(popView: popUpView)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func closePopUp(_ sender: Any) {
        blackView.close(popView: popUpView)
    }
    @IBAction func typeOfActivities(_ sender: Any) {
        
        self.viewForTable.frame = CGRect(x: self.typeofactivityButton.frame.origin.x, y: self.typeofactivityButton.frame.origin.y + self.typeofactivityButton.frame.height , width: self.typeofactivityButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.typeofactivityButton.frame.origin.x, y: self.typeofactivityButton.frame.origin.y + self.typeofactivityButton.frame.height, width: self.typeofactivityButton.frame.width, height: self.typeofactivityButton.frame.height * 5)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    @IBAction func add(_ sender: Any) {
        physicalActivities()
//        APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Name field is empty.")

    }
    @IBAction func addNew(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    @IBAction func none(_ sender: Any) {
    }
    
    func physicalActivities() {
        let uId = APIManager.sharedInstance.getLoggedInUser()!.id!
        let parameterDictionary = [
            "id": uId,
            "Name":"\(activityLabel.text!)",
            "Frequency":"\(textfield.text!)"
        ]
            activities.addPhysicalActivity(parameterDictionary: parameterDictionary, completion: { (activity) in
                DispatchQueue.main.async {
                    self.activities.allPhysicalActivity(parameterDictionary: ["id" :  uId], completion: { (allactivity) in
                        DispatchQueue.main.async {
                            self.allActivities = allactivity
                            self.lifeTableView.reloadData()
                            self.lifeTableView.isHidden = false
                            self.addMoreView.isHidden = false
                        }
                    })
                     self.blackView.close(popView: self.popUpView)
                }
            })
      
        
        
    }
    
    
    
    @IBAction func addMore(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)

    }
    
    
    
    
    
    
    
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == lifeTableView {
            return allActivities?.result.count ?? 0
        }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == lifeTableView {
            let cell1 = lifeTableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = allActivities?.result[indexPath.row].Name
            return cell1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == lifeTableView {}else {
        activityLabel.text = array[indexPath.row]
        activityLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        viewForTable.removeFromSuperview()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if keyboardFirstTime == true
        {
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                self.viewMoveUp(popUpView: self.popUpView, value: self.textfield)
                self.textfieldLabel.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            }
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.popUpView.frame = self.fra
        gesture.isEnabled = true
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    func viewMoveUp(popUpView: UIView, value: UITextField) {
        self.fra = self.popUpView.frame
        gesture.isEnabled = false
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























