//
//  NameCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 23/11/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class NameCell: UICollectionViewCell {
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
    var onlineViewProfile:(()-> Void)!


    @IBAction func getAppointmentAction(_ sender: Any) {
    }
    
    @IBAction func instantConsultation(_ sender: Any) {
//        self.instantConsultation()
        
        if let ConsultationVC = SKStoryBoard.CONSULTATION_SB.instantiateViewController(withIdentifier: "ConsultationVC") as? ConsultationVC {
            
            
            ConsultationVC.commingData = self.selectedDict
            //            ConsultationVC.commingData = self.selectedDict;
            
            if let top = UIApplication.topViewController() {
                top.navigationController?.pushViewController(ConsultationVC, animated: true)
            }
        }
    }
    
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
//
//                let icon = self.viewWithTag(10) as? UIImageView
//                icon?.image = icon?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//
//                let label = self.viewWithTag(100) as? UILabel
                
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
    
    @IBAction func viewOninePorfile(_ sender: Any) {
        self.onlineViewProfile()
    }
    @IBAction func offlineViewProfile(_ sender: Any) {
        self.viewProfile()
    }



    func instantConsultation() -> Void {

        if let ConsultationVC = SKStoryBoard.CONSULTATION_SB.instantiateViewController(withIdentifier: "ConsultationVC") as? ConsultationVC {


            ConsultationVC.commingData = self.selectedDict
            //            ConsultationVC.commingData = self.selectedDict;

            if let top = UIApplication.topViewController() {
                top.navigationController?.pushViewController(ConsultationVC, animated: true)
            }
        }

    }


    
//     func setSelected(_ selected: Bool, animated: Bool) {
////        super.setSelected(selected, animated: animated)
//        self.backgroundColor = selected ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.0967096434) : UIColor.clear
//        self.viewHolder.backgroundColor = isSelected ? #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//                    self.drImage.layer.borderColor = isSelected ?  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
//                    drName.isHidden = isSelected ? true : false
//                    drSpeciality.isHidden = isSelected ? true : false
//                    drExperience.isHidden = isSelected ? true : false
//                    drDescription.isHidden = isSelected ? true : false
//
//                    addFav.isHidden = isSelected ? true : false
//                    star.isHidden = isSelected ? true : false
//                    availableDot.isHidden = isSelected ? true : false
//                    available.isHidden = isSelected ? true : false
//                    topView.isHidden = isSelected ? false :true
//    }
//    override var isSelected: Bool { // keep lightGray background until unselected (保留灰背景)
//        willSet {
//            self.viewHolder.backgroundColor = isSelected ? #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//            self.onlineTopView.backgroundColor = isSelected ? #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//
//            drName.isHidden = isSelected ? true : false
//            drSpeciality.isHidden = isSelected ? true : false
//            drExperience.isHidden = isSelected ? true : false
//            drDescription.isHidden = isSelected ? true : false
//            drImage.isHidden = isSelected ? true : false
//
//            addFav.isHidden = isSelected ? true : false
//            star.isHidden = isSelected ? true : false
//            availableDot.isHidden = isSelected ? true : false
//            available.isHidden = isSelected ? true : false
//
//            if available.text == "Online" {
//                onlineTopView.isHidden = isSelected ? false : true
//            }else {
//               topView.isHidden = isSelected ? false :true
//            }
//
//
//
////            onSelected(newValue)
//        }
//    }
//    func onSelected(_ newValue: Bool) {
////        guard selectedBackgroundView == nil else { return }
////        if shouldTintBackgroundWhenSelected {
////            contentView.backgroundColor = newValue ? cellHighlightedColor : UIColor.clear
////        }
////        if let sa = specialHighlightedArea {
////            sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : UIColor.clear
////        }
//    }
    

}



























