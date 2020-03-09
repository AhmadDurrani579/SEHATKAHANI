//
//  CareerProfile.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 02/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class CareerProfile: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let section = ["Specialities", "PMDC Licence", "Experience", "Fee Charge", "Hospital Clinic","Work Number", "Work Address"]
    
    let array = [("Specialities",["GENERAL PHYSICIAN","MAGICIAN","COOK"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"])]
    
//    let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]
    @IBOutlet weak var drImage: ImageSetting!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        drImage.cornerRadius1()
        let nibName = UINib(nibName: "CareerProfileCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CareerProfileCell")
        
        let customheader = UINib(nibName: "CustomHeaderSection", bundle: nil)
        tableView.register(customheader, forCellReuseIdentifier: "CustomHeaderSection")
        
        let customfooter = UINib(nibName: "CustomFooterSection", bundle: nil)
        tableView.register(customfooter, forCellReuseIdentifier: "CustomFooterSection")
        
        tableView.backgroundColor = UIColor.clear
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.sectionFooterHeight = 0.0
        
        tableView.layer.opacity = 1
        tableView.layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
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
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderSection") as! CustomHeaderSection
        headerCell.frame.size.width = tableView.frame.width
        headerCell.frame.size.height = 50
        headerView.addSubview(headerCell)
        headerCell.titleLabel.text = self.array[section].0
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomFooterSection") as! CustomFooterSection
        headerCell.frame.size.width = tableView.frame.width
        headerCell.frame.size.height = 0
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return .leastNonzeroMagnitude
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.clear
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
