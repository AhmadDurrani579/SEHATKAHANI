//
//  SKPrecriptionTabletsTableViewCell.swift
//  test
//
//  Created by M Abubaker Majeed on 29/01/2018.
//  Copyright © 2018 M Abubaker Majeed. All rights reserved.
//

import UIKit

class SKPrecriptionTabletsTableViewCell: UITableViewCell {

    @IBOutlet var bottonConstraint: NSLayoutConstraint!
    @IBOutlet var topHeightContant: NSLayoutConstraint!
    @IBOutlet var lblTabletName: UILabel!
    @IBOutlet var lblDosageDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
