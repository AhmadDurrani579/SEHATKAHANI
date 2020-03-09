//
//  UpcomingCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 26/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class UpcomingCell: UICollectionViewCell {
 
    @IBOutlet weak var viewHolder: UIViewX!
    @IBOutlet weak var deImage: UIImageView!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drSpeciality: UILabel!
    
    override func awakeFromNib() {
                viewHolder.layer.cornerRadius = contentView.frame.height / 8
//        self.deImage.frame.size.height = self.viewHolder.frame.height / 2
//        self.deImage.frame.size.width = self.viewHolder.frame.height / 2
        self.deImage.cornerRadius2()
    }
}
