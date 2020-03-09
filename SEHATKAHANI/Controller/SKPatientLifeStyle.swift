//
//  SKPatientLifeStyle.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 30/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKPatientLifeStyle: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var patientHistoryArray = ["Current Medication","Physical Activity","Social Activity"]
    //     var patineHistory: GetPastDisease?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName = UINib(nibName: "CareerProfileCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CareerProfileCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return patientHistoryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerProfileCell", for: indexPath)   as! CareerProfileCell
        cell.backgroundColor = UIColor.clear
        cell.nextLogo.isHidden = false
        cell.titleLabel.text = patientHistoryArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  45
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 10
    //    }
    
    //    func getPatientPastHis()  {
    //                self.id = APIManager.sharedInstance.getLoggedInUser()?.id
    //
    //                let idofAppointmet = [  "id"        : id
    //                    ] as [String : AnyObject]
    //                WebServiceManager.post(params: idofAppointmet , serviceName: GET_PastDisease, serviceType: "Cancel Appointment" , modelType: GetPastDisease.self, success: { (response) in
    //
    //                self.patineHistory = (response as! GetPastDisease)
    //
    //                    DispatchQueue.main.async {
    //                        self.tableView.delegate = self
    //                        self.tableView.dataSource = self
    //                        self.tableView.reloadData()
    //                    }
    //
    //                }, fail: { (error) in
    //
    //                }, showHUD: true)
    //
    //
    //    }
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
