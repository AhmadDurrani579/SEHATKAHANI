//
//  SpecialityHeaderView.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 27/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SpecialityHeaderView: UICollectionReusableView,UITextFieldDelegate {
        
    @IBOutlet weak var searchTextfield: TextFieldView!
    var nameHandler:(()-> Void)!
    
    @IBAction func n(_ sender: Any) {
        self.nameHandler()
    }
    override func awakeFromNib() {
        searchTextfield.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
