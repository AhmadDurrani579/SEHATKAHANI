//
//  FavouriteCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 20/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit



class FavouriteCell: UICollectionViewCell {
    @IBOutlet weak var viewHolder: UIViewX!
    @IBOutlet weak var drImage: UIImageView!
    @IBOutlet weak var drDescription: UILabel!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drSpeciality: UILabel!
    @IBOutlet weak var drExperience: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var availableDot: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var addFav: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var onlineTopView: UIView!


    var selectedDict: DBNameResults1!
    var viewProfile:(()-> Void)!
    var viewProfileOffline:(()-> Void)!
    override func awakeFromNib() {
        //        viewHolder.layer.cornerRadius = contentView.frame.height / 2
        drImage.cornerRadius()
        clipsToBounds = false
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected;
        }
        
        set {
            if (super.isSelected != newValue) {
                super.isSelected = newValue
                let label = self.viewWithTag(100) as? UILabel
                
                if (newValue == true) {
                    viewHolder.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
                    onlineTopView.backgroundColor =  #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
                    drName.isHidden = true
                    drSpeciality.isHidden = true
                    drExperience.isHidden = true
                    drDescription.isHidden = true
                    drImage.isHidden = true
                    
                    addFav.isHidden = true
                    star.isHidden = true
                    availableDot.isHidden = true
                    available.isHidden = true
                    
                    if available.text == "Online" {
                        onlineTopView.isHidden = false
                    }else {
                        topView.isHidden = false
                    }
                    
                } else {
                    viewHolder.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                    onlineTopView.backgroundColor =  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                    
                    drName.isHidden = false
                    drSpeciality.isHidden = false
                    drExperience.isHidden = false
                    drDescription.isHidden = false
                    drImage.isHidden = false
                    
                    addFav.isHidden = false
                    star.isHidden = false
                    availableDot.isHidden = false
                    available.isHidden = false
                    
                    if available.text == "Online" {
                        onlineTopView.isHidden = true
                    }else {
                        topView.isHidden = true
                    }
                    
                }
            }
        }
    }
    @IBAction func viewPofile(_ sender: Any) {
        self.viewProfile()
    }
    @IBAction func viewProfileOffline(_ sender: Any) {
        self.viewProfile()
    }

    @IBAction func getAppointment(_ sender: Any) {

        
    }
   
    @IBAction func instantConsultation(_ sender: Any) {
        if let ConsultationVC = SKStoryBoard.CONSULTATION_SB.instantiateViewController(withIdentifier: "ConsultationVC") as? ConsultationVC {
            
            
            ConsultationVC.commingData = self.selectedDict
//            ConsultationVC.commingData = self.selectedDict;

            if let top = UIApplication.topViewController() {
                top.navigationController?.pushViewController(ConsultationVC, animated: true)
            }
        }
    }
    @IBAction func viewProfile(_ sender: Any) {
    }
    
    @IBAction func iConsultation(_ sender: Any) {
        if let ConsultationVC = SKStoryBoard.CONSULTATION_SB.instantiateViewController(withIdentifier: "ConsultationVC") as? ConsultationVC {
            
            
            ConsultationVC.commingData = self.selectedDict
            //            ConsultationVC.commingData = self.selectedDict;
            
            if let top = UIApplication.topViewController() {
                top.navigationController?.pushViewController(ConsultationVC, animated: true)
            }
        }
        
    }
    
    
    @IBAction func favViewProfile(_ sender: Any) {
        self.viewProfile()
    }
    @IBAction func favViewProfileOffline(_ sender: Any) {
        self.viewProfileOffline()
    }

    
}

























