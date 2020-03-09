//
//  SKPatientSummaryViewController.swift
//  test
//
//  Created by M Abubaker Majeed on 29/01/2018.
//  Copyright © 2018 M Abubaker Majeed. All rights reserved.
//

import UIKit

class SKPatientSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var array = [About]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: ImageSetting!
    var summaryOfDoctorObject: PatientSummaryObject?
    var consultent : ConsultationDetail?
    var patientID: String!
    
    @IBOutlet weak var topView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Prescription"
        
        self.array.append(About(section: "Description", rows: [(title: "Description", subtitle: "", des: "", img: "")]))
        self.array.append(About(section: "Summary", rows: [(title: "Summary", subtitle: "", des: "", img: "")]))
//        self.array.append(About(section: "Note", rows: [(title: "Note", subtitle: "", des: "", img: "")]))
        self.array.append(About(section: "Prescription", rows: [(title: "Prescription", subtitle: "", des: "", img: ""),(title: "Prescription", subtitle: "", des: "", img: ""),(title: "Prescription", subtitle: "", des: "", img: "")]))
        
        //        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.dataSource = self
        //        tableView.delegate = self
        
        //        headerImage.cornerRadius3()
        
        let nibName = UINib(nibName: "SingleNoteCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SingleNoteCell")
        
        let nibName1 = UINib(nibName: "SingleNote2Cell", bundle: nil)
        tableView.register(nibName1, forCellReuseIdentifier: "SingleNote2Cell")
        getAllPendingAppointment()
        
    }
    
    
    func getAllPendingAppointment() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if let id = delegate.consultId {
            let idofAppointmet = [ "Id"        : id
                ] as [String : AnyObject]
            WebServiceManager.post(params: idofAppointmet , serviceName: GET_ConsultantDetail, serviceType: "Consultant Detail" , modelType: ConsultationDetail.self, success: { (response) in
                self.consultent = (response as! ConsultationDetail)
            
                if  self.consultent?.success == true {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    self.tableView.estimatedRowHeight = 100
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    
                    
                }else {
                    APIManager.sharedInstance.customAlert(viewcontroller: self, message: (self.consultent?.message)!)
                }
            }, fail: { (error) in
                
            }, showHUD: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2  {
            return self.consultent?.presCription?.count ?? 0
        } else {
            return array[section].rows.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.array[indexPath.section].section == "Description" {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "SingleNoteCell", for: indexPath) as! SingleNoteCell
            cell.title.text  = "Description"
            if let  detil = self.consultent?.consultation?.Description {
                cell.lblDescription.text = detil
            } else {
                cell.lblDescription.text = " "
                
            }
            return cell
        }
//        if self.array[indexPath.section].section == "Note" {
//            let cell  = tableView.dequeueReusableCell(withIdentifier: "SingleNoteCell", for: indexPath) as! SingleNoteCell
//            //            cell.title.text = self.array[indexPath.section].section
//            cell.title.text  = "Note"
//
//            if let note = self.consultent?.consultation?.Notes {
//                cell.lblDescription.text = note
//
//            } else {
//                cell.lblDescription.text = " "
//            }
//
//            return cell
//        }
        
        if self.array[indexPath.section].section == "Summary" {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "SingleNoteCell", for: indexPath) as! SingleNoteCell
            //            cell.title.text = self.array[indexPath.section].section
            cell.title.text  = "Summary"
            
            if let sumary = self.consultent?.consultation?.Summary {
                cell.lblDescription.text = sumary
                
            } else {
                cell.lblDescription.text = " "
            }
            return cell
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SingleNote2Cell", for: indexPath) as! SingleNote2Cell
                cell2.lblDose.text = self.consultent?.presCription![indexPath.row].dosage
                cell2.lblNote.text = self.consultent?.presCription![indexPath.row].note
                cell2.lblName.text = self.consultent?.presCription![indexPath.row].drugName
                
                //            cell2.sepratar.isHidden = true
                
                if indexPath.row == 0 {
                    cell2.topView.isHidden = false
                    cell2.topconstant.constant = 45
                    cell2.bottomView.isHidden = true
                }else {
                    cell2.topView.isHidden = true
                    cell2.topconstant.constant = 0
                }
                if indexPath.row == ((self.consultent?.presCription?.count)! - 1) {
                    cell2.sepratar.isHidden = true
                    cell2.bottomView.isHidden = false
                    cell2.bottomConstant.constant = 45
                }else {
                    cell2.sepratar.isHidden = false
                    cell2.bottomView.isHidden = true
                    cell2.bottomConstant.constant = 0
                }
            return cell2
        }
        
    }
    
}


























