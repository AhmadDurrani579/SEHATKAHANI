//
//  ADDPrescriptionVC.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 01/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ADDPrescriptionVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var prescriptionList: Prescription?
    let ap = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var txtDosage: UITextField!
    @IBOutlet var txtDrugName: UITextField!
    @IBOutlet var txtName: UITextField!

    @IBOutlet var popView: UIView!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        popView.isHidden = true
        
//
//        let rightArrow : UIView = UIView.init(frame: CGRect (x : 0 , y : 0 , width : 100 , height : 100))
//        let btn1 = UIButton(type: .custom)
//        btn1.setImage(UIImage(named: "pre"), for: .normal)
//        btn1.imageView?.contentMode = .scaleAspectFit
//        btn1.inputView?.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
//        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn1.addTarget(self, action: #selector(ADDPrescriptionVC.addPrescription), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: btn1)
//        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        getAllPendingAppointment()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnPopUp(_ sender: Any) {
        
        popView.isHidden = false
        
    }
    
    @IBAction func btnAddPrescription(_ sender: UIButton) {
        let idOfUser =  ap.consultId
        
        let idofAppointmet = ["consultationId":  idOfUser! ,
                              "doctorId"      :  APIManager.sharedInstance.getId(),
                              "patientId"     :  ap.doctorConsultPatiendID! ,
                              "drugname"      :  txtDrugName.text! ,
                              "dosage"        :  txtDosage.text! ,
                              "note"          :  txtName.text! ,


                              

            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETPatientADPrescription, serviceType: "Prescription" , modelType: Prescription.self, success: { (response) in
            self.prescriptionList = (response as! Prescription)
            
            if self.prescriptionList?.consultation == nil {
                self.popView.isHidden = true

            } else {
                if  self.prescriptionList?.success == true {
                    self.popView.isHidden = true
                    self.getAllPendingAppointment()
                    
//                    self.tableView.delegate = self
//                    self.tableView.dataSource = self
//                    self.tableView.reloadData()
//                    self.tableView.estimatedRowHeight = 100
//                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    
                }else {
                }
                
            }
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
    }
    func addPrescription() {
        print("hello")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func getAllPendingAppointment() {
        let idOfUser =  ap.consultationIdOfDoctor
        
        let idofAppointmet = ["Id"        : idOfUser
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GETPatientPrescription, serviceType: "Prescription" , modelType: Prescription.self, success: { (response) in
            self.prescriptionList = (response as! Prescription)
            
            if self.prescriptionList?.consultation == nil {
                
            } else {
                if  self.prescriptionList?.success == true {
                   
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.tableView.estimatedRowHeight = 100
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    
                }else {
                }
                
            }
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.prescriptionList?.presCription == nil {
            return 0
        } else {
            return (self.prescriptionList?.presCription?.count)!;
            
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:PerceptionCell = self.tableView.dequeueReusableCell(withIdentifier: "PerceptionCell") as! PerceptionCell!
        cell.lblDrugName.text = self.prescriptionList?.presCription![indexPath.row].drugName
        cell.lblDosageName.text = self.prescriptionList?.presCription![indexPath.row].dosage
        cell.lblNote.text = self.prescriptionList?.presCription![indexPath.row].note

//        if indexPath.row == 0 {
//            cell.bottonConstraint.constant = 0;
//        }else{
//            cell.topHeightContant.constant = 0;
//
//        }
//
//        cell.contentView.layoutIfNeeded()
//        cell.contentView.setNeedsLayout()
//        cell.layoutIfNeeded()
//        cell.setNeedsLayout()
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}
