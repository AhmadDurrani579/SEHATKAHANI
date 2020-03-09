//
//  SKMyQueries.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 31/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class SKMyQueries: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mypreviousQbtn: UIView!
    var name: String?
    var queries: ForumQuries?
    var type: Type1!
    
    enum `Type1` {
        case allQueries
        case myQueries
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(MYQuery)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.type = Type1.allQueries
        tableView.rowHeight = UITableViewAutomaticDimension
        let nibName = UINib(nibName: "SKQuestionForumTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SKQuestionForumTableViewCell")
           getMyQueries()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.layoutSubviews()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.queries?.result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SKQuestionForumTableViewCell", for: indexPath)   as! SKQuestionForumTableViewCell
        
        cell.lblQuestion.text = queries?.result![indexPath.row].question
        cell.lblUserName.text = queries?.result![indexPath.row].userId?.name?.first
        cell.lblDate.text = queries?.result![indexPath.row].data
        if let date = queries?.result![indexPath.row].count {
            cell.btnAns.setTitle("\(date)", for: .normal)
        }
        if let url = queries?.result![indexPath.row].userId?.patientPhotos?.url{
            let resource = ImageResource(downloadURL:  URL(string: url)!, cacheKey: url)
            cell.imgeAvatar.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
            }, completionHandler: nil)
        }
    
            if indexPath.row == 0 {
                cell.setResonseCell(isResponse: false)
                cell.setAnsCell(isAnsCell: true)
            }else {
                cell.setResonseCell(isResponse: true)
                cell.setAnsCell(isAnsCell: false)
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getMyQueries()
    }
    
  
    @IBAction func addReply(_ sender: Any) {
     
        
    }
    
    func getMyQueries()  {
        self.type = Type1.myQueries
        let idofAppointmet = [  "Id"        : APIManager.sharedInstance.getLoggedInUser()?.id
            ] as [String : AnyObject]
        WebServiceManager.post(params: idofAppointmet , serviceName: FORUM_GET_MY_GUERY, serviceType: "My Quries" , modelType: ForumQuries.self, success: { (response) in
            
            self.queries = (response as! ForumQuries)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
            
            
            
        }, fail: { (error) in
        }, showHUD: true)
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

