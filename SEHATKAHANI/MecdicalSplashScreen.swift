//
//  MecdicalSplashScreen.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 12/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class MecdicalSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var gameTimer: Timer!
        
        gameTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        
        
        // Do any additional setup after loading the view.
    }
    
    func runTimedCode () {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "medicationCard") as UIViewController
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
