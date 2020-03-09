//
//  History.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 28/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class History: UITableViewCell {
     @IBOutlet weak var missedButtonLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drImage: UIImageView!
    @IBOutlet weak var drName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var dateLbl:  UILabel!
    
    @IBOutlet weak var viewHolder: UIViewX!

     var closeHandler:(()-> Void)!
    
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
        
        self.closeHandler()
    }
    
}
