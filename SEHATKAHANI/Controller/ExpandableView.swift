//
//  PatientHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

struct Paory {
    var name:String!
    var list: [String]!
    var expanded: Bool!
    
    init(name: String, list: [String], expanded: Bool) {
        self.name = name
        self.list = list
        self.expanded = expanded
    }
}


import UIKit

class ExpandableView: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: ImageSetting!
    
    @IBOutlet weak var roundedFooter: UIView!
    @IBOutlet weak var roundedHeader: UIViewX!
    
    let array = [("Specialities",["GENERAL PHYSICIAN","MAGICIAN","COOK"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"]),("PMDC Licence",["284268","2842688430"]),("Experience",["3Y 5M"])]
    
    var sections = [Paory(name: "ALLERGY", list: ["STRING","STRING","STRING"], expanded: false),Paory(name: "SURGICAL TREATMENTS", list: ["STRING","STRING","STRING"], expanded: false),Paory(name: "STRING 3", list: ["String","STRING","STRING"], expanded: false),Paory(name: "STRING 4", list: ["String","STRING","STRING"], expanded: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        roundedHeader.layer.cornerRadius = 15
        roundedFooter.layer.cornerRadius = 15
        headerImage.cornerRadius3()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "History"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PatientHistoryCell
        cell.title.text = "\(indexPath.row + 1)- "+sections[indexPath.section].list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if (sections[indexPath.section].expanded) {
                return 33
            } else{
                return 0
            }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = ExpandableHeaderView()
            header.customInit(title: sections[section].name, section: section, delegate: self)
            header.backgroundView?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            return header
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        if tableView == tableView {
//            cell.alpha = 0
//            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 250, 0)
//            cell.layer.transform = transform
//            UIView.animate(withDuration: 0.7) {
//                
//                cell.alpha = 1
//                cell.layer.transform = CATransform3DIdentity
//            }
//        }
//    }

    
    //MARK : - Confirming header view protocol.
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
        //        sections[section].expanded = !sections[section].expanded
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        //        for i in 0..<sections[section].subCategories.count {
        for i in 0..<sections[section].list.count {
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}














