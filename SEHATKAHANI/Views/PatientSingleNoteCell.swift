//
//  PatientSingleNoteCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class PatientSingleNoteCell: UITableViewCell {

    @IBOutlet var lblTreatmentTitle: UILabel!
    @IBOutlet var lblTitleOfSymptom: UILabel!
    @IBOutlet var lblTreatment: UILabel!
    @IBOutlet var lblSymptom: UILabel!
    @IBOutlet var lblDrugName: UILabel!
    @IBOutlet var viewHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewHolder.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
