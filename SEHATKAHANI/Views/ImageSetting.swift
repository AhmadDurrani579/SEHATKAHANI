//
//  ImageSetting.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 19/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ImageSetting: UIImageView {

    func imageCorner(value: CGFloat) {
        self.layer.cornerRadius = self.layer.frame.height / value
    }
    func imageBorderColor()  {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
