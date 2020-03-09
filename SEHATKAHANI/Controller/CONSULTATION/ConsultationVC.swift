//
//  ConsultationVC.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 27/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ConsultationVC: UIViewController {
    
    var commingData : DBNameResults1!
//    var commingData : DBNameResults1!
    @IBOutlet var viewConfirmation: UIView!
    @IBOutlet var btnBookAppointment: UIButton!
    @IBOutlet var btnFindAnotherDoc: UIButton!

    @IBAction func clickFindAnotherDoctor(_ sender: Any) {
    }

    @IBAction func clickAppointment(_ sender: Any) {
        
        
    }


    @IBOutlet var viewBottomLine: UIView!
    @IBOutlet var viewCentral: UIView!
    @IBOutlet var txtDescription: UITextView!
    let waitingForDoctor : waitingForDoctor = UIView.fromNib()
    var responseTimer = Timer()
    var totalTime : Float = 60;
    @IBAction func startAction(_ sender: Any) {

        self.startConsultation();
    }
    var consultationId: String!
   
    @IBOutlet var btnStart: UIButton!
    @IBOutlet var btnCancel: UIButton!
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.viewCentral.layer.cornerRadius = 20;
            self.viewBottomLine.layer.cornerRadius = 5;
            self.btnStart.layer.cornerRadius = 10;
            self.btnCancel.layer.cornerRadius = 10;


            self.viewConfirmation.layer.cornerRadius = 20;
            self.btnBookAppointment.layer.cornerRadius = 10;
            self.btnFindAnotherDoc.layer.cornerRadius = 10;

            self.viewCentral.isHidden = false;
            //self.viewConfirmation.isHidden = false;

        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.chatViewController(_:)), name: NSNotification.Name(rawValue: "checkInvitation"), object: nil)

        SKSocketConnection.socketSharedConnection.rejectConsultationListner { (data, sata) in
            debugPrint(data)
            self.waitingForDoctor.removeFromSuperview()
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Consultaion request rejected..")
            self.responseTimer.invalidate()
            self.totalTime = 60
        }
        
    }

    @IBAction func cancelAction(_ sender: Any) {
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKChatVC") as? SKChatVC
//        navigationController?.pushViewController(newViewController!, animated: true)

//        let storyBoard: UIStoryboard = UIStoryboard(name: "consultationNewPatientAndDoctor", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKDoctorPreceptionViewController") as? SKDoctorPreceptionViewController
//        navigationController?.pushViewController(newViewController!, animated: true)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {

        SKSocketConnection.socketSharedConnection.getSocketCurrentState { (isConnected, currentState) in

            if isConnected {
                SKSocketConnection.socketSharedConnection.addActiveUsers(userId: APIManager.sharedInstance.getId())
            }else {
                
                SKSocketConnection.socketSharedConnection.connectSocket(userId: (APIManager.sharedInstance.getLoggedInUser()?.id!)! , sessionId: APIManager.sharedInstance.randomString(length: 8))
//
////                 SKSocketConnection.socketSharedConnectasdfion.connectSocket(userId: "5a5dca737b4e5b3d4c4797ff", sessionId: "5a5dca737b4e5b3d4c4797ff")
//
            }
        }



    }

    // must be internal or public.
    @objc func update() {
        // Something cool
        if totalTime > 0 {
            
          totalTime = totalTime - 1;
            self.waitingForDoctor.rippleAffect()
            self.waitingForDoctor.lblTime.text = NSString(format: "%.0f", totalTime) as String
        }else if totalTime == 0 {
            SKSocketConnection.socketSharedConnection.missedConsultation(doctorID: self.commingData.UserId._id!, consultationID: consultationId)
            self.waitingForDoctor.removeFromSuperview()
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "Consultaion request missed..")
            self.responseTimer.invalidate()
            self.totalTime = 60
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
    
    
    func chatViewController(_ notification: NSNotification) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DemoChatVC") as? DemoChatVC
//        navigationController?.pushViewController(newViewController!, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKChatVC") as? SKChatVC
        navigationController?.pushViewController(newViewController!, animated: true)
        self.responseTimer.invalidate()
//        self.totalTime = 60
  }
    
    func successWaitingForDoctorView() -> Void {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "KSBConsultation", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SKChatVC") as? SKChatVC
//        navigationController?.pushViewController(newViewController!, animated: true)

        DispatchQueue.main.async {


            self.waitingForDoctor.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(self.waitingForDoctor);


            self.responseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

            UIView.animate(withDuration: 0.15, animations: {

                self.waitingForDoctor.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)

            }) { (compelte) in

            }

        }
    }


    func startConsultation() -> Void {
        
        let Url = String(format: APIManager.sharedInstance.baseUrl+"/api/MobileApp/consultation/request_consultation")
//        let patientID = APIManager.sharedInstance.getId()
        let userInfo = APIManager.sharedInstance.getLoggedInUser()
        guard URL(string: Url) != nil else { return }
        let parameterDictionary = [

            "description":  txtDescription.text! ,
            "PatientId":    userInfo?.id ,
            "DoctorId":     self.commingData.UserId._id
        ]
     
        APIManager.POST(url: Url , parameters: parameterDictionary as [String : AnyObject]) { (responseString, json) in
            debugPrint(json?.string ?? "")
            if let jsonDict = json?.dictionaryObject {
                 let consultedId = jsonDict["consultationId"] as? String
                if (jsonDict["consultationId"] as? String) != nil {
                    self.successWaitingForDoctorView();
                    self.consultationId = consultedId
                    SKSocketConnection.socketSharedConnection.consultationCalling(patientid:(userInfo?.id!)! , doctorid:  self.commingData.UserId._id!, consultationid: consultedId!, userName: "Patient"   , userType: SKUserType.patient)
                    return;
                }
            }
            APIManager.sharedInstance.customAlert(viewcontroller: self, message: "unable to call data")
        }

    }

}
