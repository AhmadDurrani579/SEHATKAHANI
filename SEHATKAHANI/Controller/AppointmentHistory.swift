//
//  History.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 28/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class AppointmentHistory: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var closeButton: UIButton!

    var array = ["","","","","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()

                
        let nibName = UINib(nibName: "History", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HistoryCell")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "History"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! History
                cell.closeHandler = {()-> Void in
                    self.detailpopUpView(index: indexPath.row)
                }
        //        cell.drType.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }

    
    func detailpopUpView(index: Int) {
        
        customView()
        print("Yhaoooo" , index)
        
    }
    
    func customView() {
        let width = view.frame.width / 1.3
        let x = view.frame.width - width
        detailView.frame = CGRect(x: x / 2, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
        detailView.layer.cornerRadius = 15
        view.addSubview(detailView)
        closeButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height / 2.5
        }) { (true) in
            
        }
    }

    @IBAction func dismissButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.detailView.removeFromSuperview()
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

}























