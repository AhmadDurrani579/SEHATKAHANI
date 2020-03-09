//
//  ViewHolder.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 13/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit
import Foundation

class ViewHolder: UIButton {
    
    func cornerRaduis() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.borderColor = #colorLiteral(red: 0.1775249839, green: 0.6573027968, blue: 0.5806930661, alpha: 1)
        self.layer.borderWidth = 2
    }
   
}

