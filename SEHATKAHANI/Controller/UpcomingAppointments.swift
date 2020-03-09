//
//  UpcomingAppointments.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 28/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class UpcomingAppointments: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reasonTextField: TextFieldView!
    @IBOutlet weak var feedButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var array = ["","","","","","","",""]
    
    @IBOutlet var feedbackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reasonTextField.cornerRad1()
        reasonTextField.padding(value: 14)
        reasonTextField.delegate = self
        feedButton.cornerRad1()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        let nibName = UINib(nibName: "AppointmentsCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AppointmentsCell")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Upcoming Appointment"
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsCell", for: indexPath) as! AppointmentsCell
        cell.closeHandler = {() -> Void in
            self.detailpopUpView(index: indexPath.row)
        }
        
        cell.cancelAppointment = {() -> Void in
            self.feedBackPopUpView(index: indexPath.row)
        }
        
       
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("google.......")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 150
    }
    
    func detailpopUpView(index: Int) {
        
        customView()
        print("Yhaoooo" , index)
      
    }
    
    func feedBackPopUpView(index: Int) {
        
        feedbackCustomView()
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
    
    func feedbackCustomView() {
        let width = view.frame.width / 1.3
        let x = view.frame.width - width
        feedbackView.frame = CGRect(x: x / 2, y: view.frame.height, width: width, height: self.view.frame.height / 1.5)
        feedbackView.layer.cornerRadius = 15
        view.addSubview(feedbackView)
        closeButton.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height / 2.5
        }) { (true) in
            
        }
    }

    @IBAction func dismissButton(_ sender: Any) {
       
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.frame.origin.y = self.view.frame.height
            self.feedbackView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.detailView.removeFromSuperview()
            self.feedbackView.removeFromSuperview()
        }
        
    }
    
    
    @IBAction func feedbackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.feedbackView.frame.origin.y = self.view.frame.height
            self.closeButton.alpha = 0
        }) { (true) in
            self.feedbackView.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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





























