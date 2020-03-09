//
//  CustomExtentions.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 21/12/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
import UIKit


extension  UIImageView {
    
    func cornerRadius() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
    }
    func cornerRadius1() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        self.isHidden = false
    }
    func cornerRadius2() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        self.isHidden = false
    }
    func cornerRadius3() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        self.isHidden = false
    }
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func xView(value: CGFloat)  {
        self.layer.cornerRadius = self.frame.height / value
    }
    func xViewborder(bordervalue: CGFloat , borderColor: CGColor) {
        self.layer.borderWidth = bordervalue
        self.layer.borderColor = borderColor
    }
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UITextField {
    func textcor() {
        self.layer.cornerRadius = self.layer.frame.height / 1.9
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1).cgColor
    }
    
    func padding(value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width / value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func rightPadding(value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width / value, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
        
    }
    func rightPad(value: CGFloat) {
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        paddingView.image = UIImage(named: "magnif")
        paddingView.contentMode = .scaleAspectFit
        let vi = UIView(frame: CGRect(x: 30, y: 0, width: 50 , height: 25))
        vi.addSubview(paddingView)
        self.rightView = vi
        //        self.rightView?.frame.origin.x = -50
        self.rightViewMode = .always
        
    }
    
}


extension UIButton {
    func cornerRad() {
        self.layer.cornerRadius = self.layer.frame.height / 1.9
    }
    func cornerRad1() {
        self.layer.cornerRadius = self.layer.frame.height / 1.9
        self.layer.borderColor  = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        self.layer.borderWidth = 1
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func cornerRad2() {
        self.layer.cornerRadius = self.layer.frame.height / 1.9
        self.layer.borderColor  = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        self.layer.borderWidth = 1
    }
}


extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    var countCustom:Int {
        return self.distance(from: self.startIndex, to: self.endIndex)
    }
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    func  toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        print("Invalid arguments ! Returning Current Date . ")
        return Date()
    }
}



extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}





extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {
    
    func toDate (format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }
    
    func toDateString (inputFormat: String, outputFormat:String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
}

extension Date {
    
    func toString (format:String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}






extension Array
{
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject { return true }
                }
            }
        }
        return false
    }
}





