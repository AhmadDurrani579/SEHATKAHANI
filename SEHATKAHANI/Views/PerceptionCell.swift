//
//  PerceptionCell.swift
//  Sehat Kahani
//
//  Created by Ahmed Durrani on 01/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PerceptionCell: UITableViewCell {
    @IBOutlet var lblDrugName: UILabel!
    @IBOutlet var lblDosageName: UILabel!
    @IBOutlet var lblNote: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
