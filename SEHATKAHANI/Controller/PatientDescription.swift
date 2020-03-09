//
//  PatientDescription.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class PatientDescription: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var appointmentObj: GetPendingAppointmentObject?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: ImageSetting!
    @IBOutlet weak var lblDesciption: UILabel!

    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    let ap = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inserts = UIEdgeInsets(top: 100,left: -30,bottom: -50,right: 0)
        let imgBackArrow = UIImage(named: "arrow")?.withAlignmentRectInsets(inserts) // Load the image centered
        
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow // Set the image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        // Do any additional setup after loading the view.
        
        
        if let url = ap.appointmentObj?.patientId?.patientPhotos?.secureUrl {
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            headerImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
                
                print((1 / totalSize) * 100)
            }, completionHandler: nil)
        }

        let nibName = UINib(nibName: "descriptionCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "descriptionCell")
        
        lblDesciption.text = "Description"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
        headerImage.cornerRadius3()

    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Patient Details"

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! descriptionCell
        cell.descriptionCell.text = ap.appointmentObj?.descriptionofAppointment
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
























