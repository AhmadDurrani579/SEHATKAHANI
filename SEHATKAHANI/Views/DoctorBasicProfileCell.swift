//
//  DoctorBasicProfileCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 01/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class DoctorBasicProfileCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var viewHolder: UIViewX!
    @IBOutlet weak var doblabel: UILabel!
    @IBOutlet weak var dobfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dobfield.delegate = self
        viewHolder.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionButton(_ sender: Any) {
        doblabel.isHidden = true
        dobfield.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
