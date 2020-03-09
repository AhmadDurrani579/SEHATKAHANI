//
//  SKPhysicalAndSocial.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/02/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.


import UIKit

class SKPhysicalAndSocial: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var comment: UILabel!

    @IBOutlet weak var backgroundview: UIViewX!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundview.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
