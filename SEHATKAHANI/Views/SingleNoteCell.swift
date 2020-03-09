//
//  SingleNoteCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SingleNoteCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewHolder: UIView!
    
    @IBOutlet var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewHolder.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
