//
//  PatientHistoryCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PatientHistoryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    override  var isHighlighted: Bool {
        didSet{
            if isSelected == true {
                self.backgroundColor = isHighlighted ? UIColor.red : UIColor.black
                //                titleLabel.textColor = isExclusiveTouch ? UIColor.red : UIColor.gray
                print(12345)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
