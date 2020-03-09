//
//  SKSummaryHeaderTableViewCell.swift
//  test
//
//  Created by M Abubaker Majeed on 29/01/2018.
//  Copyright © 2018 M Abubaker Majeed. All rights reserved.
//

import UIKit

class SKSummaryHeaderTableViewCell: UITableViewCell {
    @IBOutlet var viewInside: UIView!

    @IBOutlet var lblSummaryDetail: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        viewInside.layer.cornerRadius = 10;
        viewInside.clipsToBounds = true
        viewInside.setNeedsLayout()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
