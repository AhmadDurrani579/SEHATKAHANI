//
//  MedicationCards.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 12/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Kingfisher

class MedicationCards: UIViewController {
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var shadowView: UIViewX!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var finish: UIButton!
    
    var index = 0
    var container: ContainerViewController!
    
    let viewController = ["pasthistory","cm","surgicalhistory","allergies","Immunization","lifeStylehistory","familyhistory"]
    let viewDrCard =  ["pasthistory","cm","surgicalhistory","allergies","Immunization"]
    var cardViewController = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fname = APIManager.sharedInstance.getLoggedInUser()?.name!["first"] {
            username.text = "\(fname)"
        }
        
        if(APIManager.sharedInstance.getLoggedInUser()?.isDoctor)!{
              self.cardViewController = viewDrCard
        }else{
            
             self.cardViewController = viewController
        }
        
        
//        if APIManager.sharedInstance.getisdr() == true {
//
//        }else {
//
//        }
        
        previousButton.alpha = 0
        finish.alpha = 0
        
        let center = userPhoto.center
        userPhoto.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.5, height: self.view.frame.width / 2.5)
        holderView.xView(value: 15)
        shadowView.xView(value: 15)
        userPhoto.center = center
        userPhoto.cornerRadius()
        username.frame.origin.y = userPhoto.frame.origin.y + userPhoto.frame.height

        // Do any additional setup after loading the view.

   NotificationCenter.default.addObserver(self, selector: #selector(self.nextCall(_:)), name: NSNotification.Name(rawValue: "nextCall"), object: nil)
   NotificationCenter.default.addObserver(self, selector: #selector(self.previousCall(_:)), name: NSNotification.Name(rawValue: "previousCall"), object: nil)

    }

     func nextCall(_ notification: NSNotification) {
       self.nextCard(nextButton)
     }
    func previousCall(_ notification: NSNotification) {
       self.previousCard(previousButton)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "nextCall"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {




//        if let url = APIManager.sharedInstance.getLoggedInUser()?.avatarUrl!["url"] {
//            print(url)
//            let resource = ImageResource(downloadURL:  URL(string: url as! String)!, cacheKey: url as? String)
//             self.userPhoto.kf.setImage(with: resource, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (recievedSize, totalSize) in
//
//                print((1 / totalSize) * 100)
//            }, completionHandler: nil)
//        }


    }
    @IBAction func nextCard(_ sender: Any) {
        
        if self.index < cardViewController.count - 1 {
            self.index = self.index + 1
            if self.index == cardViewController.count - 1 {
                nextButton.alpha = 0
                finish.alpha = 1
            }
            container!.segueIdentifierReceivedFromParent("\(cardViewController[index])")
            previousButton.alpha = 1
        }
    }
    
    @IBAction func previousCard(_ sender: Any) {
        if self.index > 0 {
            self.index = self.index - 1
            if self.index == 0 {
                previousButton.alpha = 0
            }
                container!.segueIdentifierReceivedFromParent("\(cardViewController[index])")
            nextButton.alpha = 1
            finish.alpha = 0
        }
    }
    
    @IBAction func skip(_ sender: Any) {
        
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Doctor") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        
//        if self.index < cardViewController.count - 1 {
//            self.index = self.index + 1
//            if self.index == cardViewController.count - 1 {
//                nextButton.alpha = 0
//            }
//            container!.segueIdentifierReceivedFromParent("\(cardViewController[index])")
//            previousButton.alpha = 1
//        }
        
    }
    
    
    @IBAction func finish(_ sender: Any) {
        if (APIManager.sharedInstance.getLoggedInUser()?.isDoctor)! {
            let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Doctor") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as UIViewController
            self.present(vc, animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
        }
    }

}













