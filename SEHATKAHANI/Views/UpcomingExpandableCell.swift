//
//  UpcomingExpandableCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 27/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

protocol CancelAppointment {
    func cancelAppointmentOfDoctor(cancel :  UpcomingExpandableCell , indexPath : IndexPath)
}
class UpcomingExpandableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var drImage: UIImageView!
    @IBOutlet weak var drType: UILabel!
    @IBOutlet var descriptionOfAppointment: UILabel!
    
    @IBOutlet var lblStartEndTime: UILabel!
    @IBOutlet weak var open: UIButton!
    @IBOutlet weak var openView: UIViewX!
    var delegate: CancelAppointment?
    var index: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        openView.layer.cornerRadius = 15
        drImage.cornerRadius3()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.backgroundColor = selected ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) : UIColor.clear
        
        // Configure the view for the selected state
    }
     var closeHandler:(()-> Void)!
    var nameHandler:(()-> Void)!

    @IBAction func closeButton(_ sender: Any) {
        self.closeHandler()
        self.delegate?.cancelAppointmentOfDoctor(cancel: self, indexPath: index!)

        print("close button")
    }
    @IBAction func nameButton(_ sender: Any) {
        self.nameHandler()
        print("nameButton button")

    }
    
    
    
//    func animate(duration:Double, c: @escaping () -> Void) {
//        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
//
//                self.stuffView.isHidden = !self.stuffView.isHidden
//                if self.stuffView.alpha == 1 {
//                    self.stuffView.alpha = 0.5
//                } else {
//                    self.stuffView.alpha = 1
//                }
//
//            })
//        }, completion: {  (finished: Bool) in
//            print("animation complete")
//            c()
//        })
//    }
//
}
