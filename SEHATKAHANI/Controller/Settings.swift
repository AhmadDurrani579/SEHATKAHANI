//
//  Settings.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 29/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    @IBOutlet weak var currentPassword: TextFieldView!
    @IBOutlet weak var newPassword: TextFieldView!
    @IBOutlet weak var confirmPassword: TextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPassword.cornerRad()
        newPassword.cornerRad()
        confirmPassword.cornerRad()
        
        currentPassword.padding(value: 14)
        newPassword.padding(value: 14)
        confirmPassword.padding(value: 14)
        
        
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.topItem?.title = "Settings"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
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
