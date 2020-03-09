//
//  AnimatedView.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 18/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class AnimatedView: UIView {
    
    func homeViewCorner(value: CGFloat) {
        self.layer.cornerRadius = self.layer.frame.height / value
    }
    
        func animation() {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
            
//            UIView.animate(withDuration: 0.3) {
//            }
//
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (true) in
                self.transform = .identity
            }
            
        }
}
