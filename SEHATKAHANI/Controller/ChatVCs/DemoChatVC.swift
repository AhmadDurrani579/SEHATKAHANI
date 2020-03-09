//
//  DemoChatVC.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 29/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class DemoChatVC: UIViewController {
    let ap = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SKSocketConnection.socketSharedConnection.chatMessage(docorid: ap.doctoID!  , patientID: APIManager.sharedInstance.getId(), senderID:APIManager.sharedInstance.getId()  , message: text , consultationid: ap.consultId!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnVideo_PRessed(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Doctor", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKVideoChatVC") as? SKVideoChatVC
        navigationController?.pushViewController(newViewController!, animated: true)

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
