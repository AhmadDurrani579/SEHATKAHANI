//
//  PatientNotes.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PatientNotes: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var image: ImageSetting!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    let ap = UIApplication.shared.delegate as! AppDelegate
    var summaryOfDoctor: PatientSummary?

    let clearView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        clearView.backgroundColor = UIColor.clear // Whatever color you like
        PatientNotesCell.appearance().selectedBackgroundView = clearView
        let xview = UIViewX()
        xview.frame = CGRect(x: 20, y: 0, width: self.view.frame.width - 40, height: 44)
        xview.backgroundColor = #colorLiteral(red: 0.9769807269, green: 0.9769807269, blue: 0.9769807269, alpha: 1)
        xview.shadowOpacity = 1
        xview.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        xview.shadowRadius = 16
        clearView.addSubview(xview)
        
//        image.cornerRadius3()
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
        getAllPendingAppointment()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Consultation History"
        
    }

    func getAllPendingAppointment() {
        let idOfPatient = ap.appointmentObj?.patientId?.patientKey
        
        let idofAppointmet = [ "Id"        : idOfPatient
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: GET_SummaryDoctor, serviceType: "Summary" , modelType: PatientSummary.self, success: { (response) in
            self.summaryOfDoctor = (response as! PatientSummary)
            
            if  self.summaryOfDoctor?.success == true {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                self.tableView.estimatedRowHeight = 100
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                
            }else {
            }
            
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (summaryOfDoctor?.result?.count)!
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PatientNotesCell
        cell.title.text  = self.summaryOfDoctor?.result![indexPath.row].name
//        cell.title.text = "Google Notes"
      
//        cell.backgroundView = clearView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "consultationHistory") as! PatientSingleConsultation
        newViewController.summaryOfDoctorObject = summaryOfDoctor?.result![indexPath.row]
        navigationController?.pushViewController(newViewController, animated: true)

//        switchToViewController(viewController: "consultationHistory")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func switchToViewController(viewController: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: viewController)
        navigationController?.pushViewController(newViewController, animated: true)
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
