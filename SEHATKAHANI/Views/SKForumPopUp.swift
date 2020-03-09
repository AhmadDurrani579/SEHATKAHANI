//
//  SKForumPopUp.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 31/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKForumPopUp: UIView {

    @IBOutlet var qtxt: UITextView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var btn: UIButton!
    var addreply:(()-> Void)!
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        bgView.layer.cornerRadius = 8
        btn.layer.cornerRadius = self.btn.frame.height / 2
    }

    @IBAction func addReply(_ sender: Any) {
        self.addreply()
    }
}
