//
//  FamilyHistoryCell.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 28/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class FamilyHistoryCell: UITableViewCell {
   
    @IBOutlet var titleOfDiesease: UILabel!
    @IBOutlet var relation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
