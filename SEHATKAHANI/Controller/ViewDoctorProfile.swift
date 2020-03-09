//
//  ViewDoctorProfile.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 22/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class ViewDoctorProfile: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var array = [(String,[String])]()
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drImage: ImageSetting!
    var drKey: String?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var isFavLabel: UILabel!
     var userInfo: GetDoctorProfile?
    enum `Type1` {
        case favourite
        case notfavourite
    }
    var type: Type1!
    
    var docName: String!
    var docId: String!
    
    let ob = ViewDocProf()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(APIManager.sharedInstance.key)
        
        drImage.cornerRadius1()
        let nibName = UINib(nibName: "CareerProfileCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CareerProfileCell")
        
        let customheader = UINib(nibName: "CustomProfileHeaderViewCell", bundle: nil)
        tableView.register(customheader, forCellReuseIdentifier: "CustomProfileHeaderViewCell")
        
        let customfooter = UINib(nibName: "CustomFooterSection", bundle: nil)
        tableView.register(customfooter, forCellReuseIdentifier: "CustomFooterSection")
        
        tableView.backgroundColor = UIColor.clear
        //        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UITableViewAutomaticDimension
  
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.sectionFooterHeight = 0.0
        
        tableView.layer.opacity = 1
        tableView.layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)

       // viewDocProf(key: APIManager.sharedInstance.key)
        
        isFavourite()
        getDoctorPrfileInfo(id: APIManager.sharedInstance.key)
        
    }
    override func viewDidLayoutSubviews() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array[section].1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerProfileCell", for: indexPath) as! CareerProfileCell
        cell.titleLabel.text = array[indexPath.section].1[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomProfileHeaderViewCell") as! CustomProfileHeaderViewCell
        headerCell.frame.size.width = tableView.frame.width
        headerCell.frame.size.height = 50
        headerView.addSubview(headerCell)
        headerCell.title.text = self.array[section].0
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomFooterSection") as! CustomFooterSection
        headerCell.frame.size.width = tableView.frame.width
        headerCell.frame.size.height = 50
        headerCell.clipsToBounds = true
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.array[section].0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }

//        func viewDocProf(key: String) {
//
//            ob.getDrbyname(url: "/api/MobileApp/appointment/view_doctor", parameterDictionary: ["userId" : "\(key)"]) { (response) in
//                if let sep = response.result.doctor._id {
////                    print("\n\n",sep,"  -  ",APIManager.sharedInstance.getId(),"\n\n")
//
//                    self.ob.checkIsFavourite(url: "/api/MobileApp/favourite/check_favourite_doctor", parameterDictionary: ["docId" : "\(sep)","patId" : "\(APIManager.sharedInstance.getToken())"], completion: { (isfavourite) in
//                         guard let isfav = isfavourite.favourite else {return}
//                        DispatchQueue.main.async {
//                            print(isfav)
//                            self.favImage.isHidden = false
//                            if isfav {
//                                self.type = Type1.favourite
//                                self.favImage.tintColor = #colorLiteral(red: 0.9951632619, green: 0.8572828241, blue: 0.4422867299, alpha: 1)
//                                self.isFavLabel.text = "Remove Favourite"
//                            }else {
//                                self.type = Type1.notfavourite
//                                self.isFavLabel.text = "Add to favourite"
//                                self.favImage.tintColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
//                            }
//                        }
//                    })
//                }
//
//                guard let spec = response.result.doctor.speciality else {return }
//                guard let qul = response.result.doctor.degree else {return}
//                guard let pmdc = response.result.doctor.medno else {return}
//                guard let docId = response.result.doctor._id else {return}
//                guard let email = response.result.email else {return}
//                guard let exp = response.result.doctor.experience else {return}
//                guard let exp1 = response.result.doctor.experiencemonths else {return}
//                guard let org = response.result.doctor.workplace else {return}
//                guard let fee = response.result.doctor.fee1 else {return}
//
//                guard let fname = response.result.name.first else {return}
//                guard let sname = response.result.name.last else {return}
//
//              self.docName = fname+" "+sname
//                self.docId = docId
//
//                print(docId  ,"", key)
//
//                if let url = response.result.photo.url {
//                    let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
//                    self.drImage.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
//                    }, completionHandler: nil)
//                }
//
//
//            self.array =  [("Speciality",["\(spec)"]),("Qualification",["\(qul)"]),("PMDC Licence",["\(pmdc)"]),("Email",["\(email)"]),("Experience",["\(exp) years \(exp1) months"]),("Fee",["\(fee)"]),("Organization",["\(org)"])]
//                DispatchQueue.main.async {
//                      self.drName.text = "\(fname) \(sname)"
//                    self.tableView.delegate = self
//                    self.tableView.dataSource = self
//                    self.tableView.reloadData()
//                    self.tableView.setNeedsLayout()
//                    self.tableView.layoutIfNeeded()
//                    self.tableView.reloadData()                }
//
//            }
//        }
    
    @IBAction func addToFavourite(_ sender: Any) {

        let idofAppointmet = [ "patId"  : APIManager.sharedInstance.getLoggedInUser()?.id,
                               "docId"       :  APIManager.sharedInstance.key
            ] as [String : AnyObject]

        if self.type == Type1.notfavourite {
            WebServiceManager.post(params: idofAppointmet , serviceName:ADD_TO_FAVOURITE, serviceType: "Add To Favourite" , modelType: GetDoctorProfile.self, success: { (response) in
                self.userInfo = (response as! GetDoctorProfile)
                if self.userInfo?.success == true {
                    self.type = Type1.favourite
                    self.favImage.tintColor = #colorLiteral(red: 0.9951632619, green: 0.8572828241, blue: 0.4422867299, alpha: 1)
                    self.isFavLabel.text = "Remove Favourite"
                }
            }, fail: { (error) in
                APIManager.sharedInstance.customAlert(viewcontroller: self, message: (self.userInfo?.message)!)
            }, showHUD: true)
      
        }else {
            WebServiceManager.post(params: idofAppointmet , serviceName:REMOVE_FROM_FAVOURITES, serviceType: "Remove From Favourites" , modelType: GetDoctorProfile.self, success: { (response) in
                self.userInfo = (response as! GetDoctorProfile)
                self.type = Type1.notfavourite
                self.isFavLabel.text = "Add to favourite"
                self.favImage.tintColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            }, fail: { (error) in
                APIManager.sharedInstance.customAlert(viewcontroller: self, message: (self.userInfo?.message)!)
            }, showHUD: true)
            
            
        }
    }
    
    func getDoctorPrfileInfo(id : String) {
        let idofAppointmet = [ "userId"  : id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName:VIEW_DOCTOR_PROFILE, serviceType: "Doctor Info" , modelType: GetDoctorProfile.self, success: { (response) in
            self.userInfo = (response as! GetDoctorProfile)
            if let name = self.userInfo?.result?.name?.first , let lname = self.userInfo?.result?.name?.last {
                self.drName.text = "\(name) \(lname)"
            }
            var speciality = "No Data"
            var degree = "No Data"
            var medno = "No Data"
            var experience = "No Data"
            var email = "No Data"
            var experienceInMonths = "No Data"
            var workPlace = "No Data"
            var fee = "No Data"
            
            DispatchQueue.main.async {
            
            if let spec = self.userInfo?.result?.doctor?.speciality {
                speciality = spec
            }
            if let qul = self.userInfo?.result?.doctor?.degree {
                degree = qul
            }
            if let pmdc = self.userInfo?.result?.doctor?.medno {
                medno = pmdc
            }
            if let emaisl = self.userInfo?.result?.email {
                email = emaisl
            }
            if let exp = self.userInfo?.result?.doctor?.experience {
                experience = exp
            }
            if let exp1 = self.userInfo?.result?.doctor?.experiencemonths {
                experienceInMonths = exp1
            }
            if let org = self.userInfo?.result?.doctor?.workplace {
                workPlace = org
            }
            if let fee1 = self.userInfo?.result?.doctor?.fee1 {
                fee = fee1
            }
            //                guard let fee = self.userInfo?.result?.doctor?.fee1 else {return print("No dataa")}
            self.array =  [("Speciality",[speciality]),("Qualification",[degree]),("PMDC Licence",[medno]),("Email",[email]),("Experience",["\(experience) years \(experienceInMonths) months"]),("Fee",["\(fee)"]),("Organization",["\(workPlace)"])]
            DispatchQueue.main.async {
                //
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                self.tableView.setNeedsLayout()
                self.tableView.layoutIfNeeded()
                self.tableView.reloadData()
            }
        }
        }, fail: { (error) in
            
        }, showHUD: true)
    }
    
    
    
    func isFavourite() {
        let isFav = [ "patId"  : APIManager.sharedInstance.getLoggedInUser()?.id,
                      "docId"   : APIManager.sharedInstance.key
            ] as [String : AnyObject]
        
        WebServiceManager.post(params: isFav , serviceName: IS_FAVOURITES, serviceType: "IsFavourites" , modelType: GetDoctorProfile.self, success: { (response) in
            let res = (response as! GetDoctorProfile)
            if res.favourite! {
                self.type = Type1.favourite
                self.favImage.tintColor = #colorLiteral(red: 0.9951632619, green: 0.8572828241, blue: 0.4422867299, alpha: 1)
                self.isFavLabel.text = "Remove Favourite"
            }else {
                self.type = Type1.notfavourite
                self.isFavLabel.text = "Add to favourite"
                self.favImage.tintColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            }
            
        }, fail: { (error) in
            
        }, showHUD: true)
        
    }
    
    
    

}























