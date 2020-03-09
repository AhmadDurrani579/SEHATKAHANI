//
//  ImmunizationCell.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ImmunizationCell: UITableViewCell {
    
    @IBOutlet var titleOfDiesease: UILabel!
    @IBOutlet var lblBooster: UILabel!
    @IBOutlet var lblNumberOfBooster: UILabel!
    
    @IBOutlet var btnBooster: UIButton!
    @IBOutlet var viewHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code\
        viewHolder.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
