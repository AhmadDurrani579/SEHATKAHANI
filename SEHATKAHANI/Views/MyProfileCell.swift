//
//  MyProfileCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 21/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class MyProfileCell: UITableViewCell {
    
    @IBOutlet weak var viewHolder: UIViewX!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var editableTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewHolder.roundCorners([.topLeft,.topRight], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//       label2.isHidden = selected ? true : false
        // Configure the view for the selected state
    }
//        override var isSelected: Bool { // keep lightGray background until unselected (保留灰背景)
//            didSet {
//                editableTextfield.isHidden = isSelected ? true : false
//            }
//        }
}
