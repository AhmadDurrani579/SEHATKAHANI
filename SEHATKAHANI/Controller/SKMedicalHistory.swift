//
//  SKMedicalHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 30/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKMedicalHistory: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    var patientHistoryArray = ["Allergy","Past Disease","Surgical History","Immunization","Family History"]
    var lifeStyle = ["Current Medication","Physical Activity","Social Activity"]
    var patientSummery: PatientSummary?
    
    var array = [String]()
    var name: String!
//     var patineHistory: GetPastDisease?
    
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tabBar.delegate = self
        
        let nibName = UINib(nibName: "SKMDCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SKMDCell")
        
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem;
        self.index = tabBar.tag
        self.array = patientHistoryArray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
     
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag  {
        case 0:
            self.array = patientHistoryArray
            self.index = item.tag
            
                tableView.delegate = self
                tableView.dataSource = self
                tableView.reloadData()
            break
        case 1:
            self.array = lifeStyle
            self.index = item.tag

            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
            break
        case 2:
            self.index = item.tag

            getPatientPastHis()
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.reloadData()

            break
        default:
            break
        }
//        tableView.reloadData()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if self.index == 2 {
            return self.patientSummery?.result?.count ?? 0
        }else {
            return array.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SKMDCell", for: indexPath)   as! SKMDCell
        cell.backgroundColor = UIColor.clear
        cell.titleLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if index == 0 {
          cell.titleLabel.text = patientHistoryArray[indexPath.row]
        }else if index == 1 {
            cell.titleLabel.text = lifeStyle[indexPath.row]
        }else if index == 2 {
            cell.titleLabel.text = patientSummery?.result![indexPath.row].name
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if index == 0 {
            self.name = patientHistoryArray[indexPath.row]
        }else if index == 1 {
            self.name  = lifeStyle[indexPath.row]
        }else if index == 2 {
            self.name  = patientSummery?.result![indexPath.row].name
        }
        
         let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if  self.index == 0 {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKSubMedicalHistory") as! SKSubMedicalHistory
            newViewController.type = indexPath.row
            newViewController.name = array[indexPath.row].lowercased()
            navigationController?.pushViewController(newViewController, animated: true)
        } 
        else if self.index == 1 {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKSubLifeStyleHistory") as! SKSubLifeStyleHistory
            newViewController.type = indexPath.row
            newViewController.name = array[indexPath.row].lowercased()
//            newViewController.name = array[indexPath.row]
            navigationController?.pushViewController(newViewController, animated: true)
        } else if self.index == 2 {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKMedicalSummery") as! SKMedicalSummery
            newViewController.type = indexPath.row
            newViewController.name = self.patientSummery?.result![indexPath.row].name?.lowercased()
            navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
 
    
    func getPatientPastHis()  {
                let id = APIManager.sharedInstance.getLoggedInUser()?.id

                let idofAppointmet = [  "id"        : id
                    ] as [String : AnyObject]
                WebServiceManager.post(params: idofAppointmet , serviceName: GET_Summary, serviceType: "Cancel Appointment" , modelType: PatientSummary.self, success: { (response) in
                    self.patientSummery = (response as! PatientSummary)
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()

                }, fail: { (error) in

                }, showHUD: true)

    }
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
