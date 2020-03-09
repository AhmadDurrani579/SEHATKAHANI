//
//  PatientBasicInfo.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class PatientBasicInfo: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: ImageSetting!
    @IBOutlet weak var lblDesciption: UILabel!

    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    
    let ap = UIApplication.shared.delegate as! AppDelegate

    
    let menuArray = [("Name","AMIN TARIQ"),("Age","25 YEARS"),("Gender","FEMALE"),("Height","6'7"),("Weight","90"),("Marital","SINGLE"),("Phone Number","03216900000"),("Blood Group","B-")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
        headerImage.cornerRadius3()
        if let url = ap.appointmentObj?.patientId?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            headerImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in

                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }
        
        lblDesciption.text = ap.appointmentObj?.patientId?.patientName?.first

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Basic Infoe"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PatientBasicCell

        if indexPath.row == 0  {
            let firtName = self.ap.appointmentObj?.patientId?.patientName?.first
            let lastName = self.ap.appointmentObj?.patientId?.patientName?.last
            cell.value.text = "\(firtName!) \(lastName!)"
            cell.title.text = "Name"
        } else if indexPath.row == 1 {
//            let db = self.ap.appointmentObj?.patientId?.dob
            if let db = self.ap.appointmentObj?.patientId?.dob {
                cell.value.text = "\(db)"
            }
            

            cell.title.text = "Age"

        } else if indexPath.row == 2 {
//            let gender = self.ap.appointmentObj?.patientId?.gender
            if let gender = self.ap.appointmentObj?.patientId?.gender {
                cell.value.text = "\(gender)"
            }

            cell.title.text = "Gender"

        }else if indexPath.row == 3 {
//            let height = self.ap.appointmentObj?.patientId?.height
            if let height = self.ap.appointmentObj?.patientId?.height {
                cell.value.text = "\(height)"
                }

            cell.title.text = "Height"

        }else if indexPath.row == 4 {
//            let wg = self.ap.appointmentObj?.patientId?.weight
            cell.title.text = "Weight"

            if let weigth = self.ap.appointmentObj?.patientId?.weight {
                cell.value.text = "\(weigth)"

            }

        }else if indexPath.row == 5 {
            if let martialS = self.ap.appointmentObj?.patientId?.martialstatus {
                cell.value.text = "\(martialS)"
                
            }

            cell.title.text = "Marital"

        }else if indexPath.row == 6 {
            if let contact = self.ap.appointmentObj?.patientId?.contactno {
                cell.value.text = "\(contact)"
                
            }
            cell.title.text = "Phone Number"

//            cell.value.text = "\(contact!)"
        }else if indexPath.row == 7 {
            if let bldGroup = self.ap.appointmentObj?.patientId?.bloodGroup {
                cell.value.text = "\(bldGroup)"

            }
            cell.title.text = "Blood Group"
        }
        
        
        return cell
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






















