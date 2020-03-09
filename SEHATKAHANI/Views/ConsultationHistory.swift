//
//  ConsultationHistory.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 12/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class ConsultationHistory: UITableViewCell {
    @IBOutlet weak var viewHolder: UIViewX!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drImage: UIImageView!
    @IBOutlet weak var timeSlot: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var dateOfAppointment: UILabel!

    var closeHandler:(()-> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        viewHolder.layer.cornerRadius = 15
        drImage.cornerRadius1()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailViewButton(_ sender: Any) {
        self.closeHandler()
    }
    
}
