//
//  SingleNote2Cell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SingleNote2Cell: UITableViewCell {

    @IBOutlet weak var sepratar: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topinnerView: UIView!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    @IBOutlet weak var topconstant: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblDose: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNote: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        topinnerView.layer.cornerRadius = 15
        bottomView.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
