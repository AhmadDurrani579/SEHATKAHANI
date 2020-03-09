//
//  SideMenuCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 19/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var sidemenuImage: UIImageView!
    @IBOutlet weak var sidemenuTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
