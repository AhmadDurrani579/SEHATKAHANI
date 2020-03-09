//
//  ViewPatientCompleteDetail.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 16/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ViewPatientCompleteDetail:  UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    var desController = UIViewController()
    var profileController = UIViewController()
    var medicalController = UIViewController()
    
    var array = [String]()
    var name: String!
    //     var patineHistory: GetPastDisease?
    
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.delegate = self
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem;
  
        // Do any additional setup after loading the view.
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "PatientDescription")
        addChildViewController(controller)
        containerView.addSubview(controller.view)
        
        self.addChildViewController(controller)
        controller.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.view.frame.height)
        self.containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)

    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag  {
        case 0:
            print("Description")
            profileController.removeFromParentViewController()
            profileController.view.removeFromSuperview()
            
            medicalController.removeFromParentViewController()
            medicalController.view.removeFromSuperview()
            
            desController = storyboard!.instantiateViewController(withIdentifier: "PatientDescription")
            self.addChildViewController(desController)
            desController.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
            self.containerView.addSubview(desController.view)
            desController.didMove(toParentViewController: self)
            
            break
        case 1:
            print("Basic profile")
            desController.removeFromParentViewController()
            desController.view.removeFromSuperview()
            
            medicalController.removeFromParentViewController()
            medicalController.view.removeFromSuperview()
            
            profileController = storyboard!.instantiateViewController(withIdentifier: "patientBasicProfile")
            self.addChildViewController(profileController)
            profileController.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
            self.containerView.addSubview(profileController.view)
            profileController.didMove(toParentViewController: self)
            
            break
        case 2:
            print("Medical history")
            
            desController.removeFromParentViewController()
            desController.view.removeFromSuperview()
            
            profileController.removeFromParentViewController()
            profileController.view.removeFromSuperview()
            
            medicalController = storyboard!.instantiateViewController(withIdentifier: "medicalHistoryController")
            self.addChildViewController(medicalController)
            medicalController.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
            self.containerView.addSubview(medicalController.view)
            medicalController.didMove(toParentViewController: self)
            
            
            break
        case 3:
            print("Consultatin history")
            break
        default:
            break
        }
        //        tableView.reloadData()
        
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

