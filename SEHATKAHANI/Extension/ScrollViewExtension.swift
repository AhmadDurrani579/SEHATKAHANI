//
//  ScrollViewExtension.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 16/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation
import UIKit
extension UIScrollView {
    
    /// listen to keyboard event
    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    /// move scroll view up
    func keyBoardDidShow(notification: Notification) {
        self.isScrollEnabled = true
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.cgRectValue.size
        
        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
        
    }
    
    /// move scrollview back down
    func keyBoardDidHide(notification: Notification) {
        // restore content inset to 0
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.cgRectValue.size
        
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
//        self.isScrollEnabled = false
    }
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
