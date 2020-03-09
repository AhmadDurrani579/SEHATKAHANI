//
//  AppointmentsCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 28/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

protocol CancelUpcomingAppointment {
    func cancelUpcomingAppointment(cancel :  AppointmentsCell , indexPath : IndexPath)
    func appointmentDetailClick(cancel :  AppointmentsCell , indexPath : IndexPath)

}

class AppointmentsCell: UITableViewCell {

    @IBOutlet weak var viewHolder: UIViewX!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drImage: UIImageView!
    @IBOutlet weak var timeSlot: UILabel!
    @IBOutlet weak var timeFromAndTo: UILabel!

    @IBOutlet weak var detailButton: UIButton!
    
    var delegate: CancelUpcomingAppointment?
    var index: IndexPath?

    
    var closeHandler:(()-> Void)!
    var cancelAppointment:(()-> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewHolder.layer.cornerRadius = 15
        drImage.cornerRadius1()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func openDetailView(_ sender: Any) {
        self.delegate?.appointmentDetailClick(cancel: self, indexPath: index!)

        self.closeHandler()
    }
    
    @IBAction func CancelAppointment(_ sender: Any) {
        self.delegate?.cancelUpcomingAppointment(cancel: self, indexPath: index!)

        self.cancelAppointment()
    }
    
    
}
