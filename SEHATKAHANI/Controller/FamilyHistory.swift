//
//  FamilyHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class FamilyHistory: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var gesture: UISwipeGestureRecognizer!
    @IBOutlet weak var addButton: ViewHolder!
    @IBOutlet var viewForTable: UIView!
    @IBOutlet weak var familyHistoryofDisease: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var familyHistoryButton: UIButton!
    @IBOutlet weak var relationButton: UIButton!
    @IBOutlet var popUpView: ViewHolder!
    @IBOutlet weak var tableView: UITableView!
    let blackView = BlackAndPopUPViews()
    @IBOutlet weak var addmoreView: UIViewX!
    
    @IBOutlet weak var familyHView: AnimatedView!
    @IBOutlet weak var familyTableView: UITableView!
    
    var familyHistory: FamilyHis?
    
    let lifeStyleHistroy = FamilyHistoryCard()
    
    let familyDisease = [
    "Achondroplasia", "Alpha-1 Antitrypsin Deficiency","Alzheimer's", "Canavan disease","Cancer", "Charcot-Marie-Tooth","Colon cancer","Color blindness","Cri du chat","Crohn's Disease", "Cystic fibrosis","Dercum Disease","Diabetes","Down Syndrome","Duane Syndrome","Duchenne Muscular Dystrophy","Bleeding disorders","Endocrine Disorders","Autism","Factor V Leiden Thrombophilia","Familial Hypercholesterolemia","Familial Mediterranean Fever","Breast cancer","Autosomal Dominant Polycystic Kidney Disease","Asthma","Anesthesia complication","Antiphospholipid Syndrome","Fragile X Syndrome","Gaucher Disease","Heart Diseases","Hemochromatosis","Hemophilia","Hepatitis B"
    ]
    var array = [String]()
    
    let relation = ["Father","Mother","Son","Daughter","Brother","Sister","Grandfather","Grandmother","Uncle","Aunt","Surrogate"]
    var bool: Bool!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addmoreView.isHidden = true
        familyTableView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        familyHView.animation()
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
    @IBAction func closePopUp(_ sender: Any) {
        blackView.close(popView: popUpView)
    }
    @IBAction func addFamilyHistory(_ sender: Any) {
        array = familyDisease
        tableView.reloadData()
        bool = true
        self.viewForTable.frame = CGRect(x: self.familyHistoryButton.frame.origin.x, y: self.familyHistoryButton.frame.origin.y + self.familyHistoryButton.frame.height , width: self.familyHistoryButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.familyHistoryButton.frame.origin.x, y: self.familyHistoryButton.frame.origin.y + self.familyHistoryButton.frame.height, width: self.familyHistoryButton.frame.width, height: self.familyHistoryButton.frame.height * 5)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
        
    }
    @IBAction func relation(_ sender: Any) {
        array = relation
        tableView.reloadData()
        bool = false
        self.viewForTable.frame = CGRect(x: self.relationButton.frame.origin.x, y: self.relationButton.frame.origin.y + self.relationButton.frame.height , width: self.relationButton.frame.width, height: 0)
        self.popUpView.addSubview(self.viewForTable)
        self.viewForTable.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewForTable.frame = CGRect(x: self.relationButton.frame.origin.x, y: self.relationButton.frame.origin.y + self.relationButton.frame.height, width: self.relationButton.frame.width, height: self.relationButton.frame.height * 5)
            self.tableView.frame = self.viewForTable.bounds
        }) { (true) in
        }
    }
    
    @IBAction func addNew(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    @IBAction func none(_ sender: Any) {
        
    }
    @IBAction func add(_ sender: Any) {
        lifeStyleHistoryFunc()
      

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == familyTableView {
            return familyHistory?.result.count ?? 0
        }
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == familyTableView {
            let cell1 = familyTableView.dequeueReusableCell(withIdentifier: "Allergies", for: indexPath) as! AllAllergiesCell
            cell1.titleLabel.text = familyHistory?.result[indexPath.row].Disease
            return cell1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TypeOfDiseaseCell
        cell.typelabel.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == familyTableView {
            
        } else {
            if self.bool == true {
                familyHistoryofDisease.text = array[indexPath.row]
                familyHistoryofDisease.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
            }else {
                relationLabel.text = array[indexPath.row]
                relationLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
            }
            viewForTable.removeFromSuperview()
        }
    }
    
    
    @IBAction func addmore(_ sender: Any) {
        blackView.BlackPopup(popView: popUpView, addButton: addButton)
    }
    
    
    
    
    
    
    func lifeStyleHistoryFunc() {
        var history = ""
        var relations = ""
        
        if self.familyHistoryofDisease.text! != "Family History of Disease" {
            history = self.familyHistoryofDisease.text!
        }
        if self.relationLabel.text! != "Relation" {
            relations = self.relationLabel.text!
        }
   
    
            let parameterDictionary = [
                "id": APIManager.sharedInstance.getLoggedInUser()!.id!,
                "Disease":"\(history)",
                "Relation":"\(relations)"
            ]

            lifeStyleHistroy.addfamilyHistory(parameterDictionary: parameterDictionary) { (response) in
                DispatchQueue.main.async {
                    self.lifeStyleHistroy.allfamilyHistory(parameterDictionary: ["id" : APIManager.sharedInstance.getLoggedInUser()!.id!], completion: { (response) in
                        DispatchQueue.main.async {
                            self.familyTableView.isHidden = false
                            self.addmoreView.isHidden = false
                            self.familyHistory = response
                            self.familyTableView.reloadData()
                        }
                    })
                
                    self.blackView.close(popView: self.popUpView)
                }
                }
            }
}




























