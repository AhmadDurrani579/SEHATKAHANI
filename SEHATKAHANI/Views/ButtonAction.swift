//
//  ButtonAction.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ButtonAction: UIButton {

    
    func action() {
    
        addTarget(self, action: #selector(LifeStyleHistory.taped), for: .touchUpInside)
    }
    
    func taped() {
        UIView.animate(withDuration: 0.3) {
//            self.alpha = 0
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
