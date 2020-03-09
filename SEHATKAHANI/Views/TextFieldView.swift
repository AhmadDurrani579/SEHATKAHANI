//
//  TextFieldView.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 17/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class TextFieldView: UITextField , UITextFieldDelegate{

    func cornerRad() {
        layer.cornerRadius = frame.height / 1.9
        layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
        layer.borderWidth = 2
    }
    func cornerRad1() {
        layer.cornerRadius = frame.height / 1.9
        layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
        layer.borderWidth = 1
    }
    
    func delegateImplementation( completion: @escaping (Bool) -> ()) {
        var label: Bool!
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0, blue: 0.3019607843, alpha: 1)
            label = true
            completion(label)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textField.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
            label = false
            completion(label)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
