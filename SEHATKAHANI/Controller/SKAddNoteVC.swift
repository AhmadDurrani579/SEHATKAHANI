//
//  SKAddNoteVC.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 01/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKAddNoteVC: UIViewController {
    
    let ap = UIApplication.shared.delegate as! AppDelegate
    var prescriptionList: Prescription?

    @IBOutlet var txtAddNote: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddNote_Pressed(_ sender: UIButton) {
        
        let idOfUser =  ap.consultId
//        let idOfUser = idOfUser
        
            let idofAppointmet = ["Id"        : idOfUser ,
                                  "notes"     : txtAddNote.text!
                ] as [String : AnyObject]
            WebServiceManager.post(params: idofAppointmet , serviceName: GETPatientADDNotes, serviceType: "Prescription" , modelType: Prescription.self, success: { (response) in
                self.prescriptionList = (response as! Prescription)
                
                if self.prescriptionList?.consultation == nil {
                    
                } else {
                    if  self.prescriptionList?.success == true {
                        self.txtAddNote.text = " "
                        
                    }else {
                    }
                    
                }
                
                
            }, fail: { (error) in
                
            }, showHUD: true)
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


