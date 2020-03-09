//
//  SKQuestionForumTableViewCell.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 30/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class SKQuestionForumTableViewCell: UITableViewCell {
    @IBOutlet var viewResponseBottom: UIView!
    @IBOutlet var bgCustomView: UIView!
    @IBOutlet var imgeAvatar: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var btnAns: UIButton!
    @IBOutlet var btnAnsHeight: NSLayoutConstraint!
    var isAnswer : Bool = false;
    var isResponseCell : Bool = false;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        self.bgCustomView.clipsToBounds = true
        self.bgCustomView.layer.cornerRadius = 8;
        self.imgeAvatar.clipsToBounds = true
        self.imgeAvatar.layer.cornerRadius = 30
    }
    public func setAnsCell(isAnsCell : Bool) -> Void {
        self.isAnswer = isAnsCell

        if( self.isAnswer) {
            self.btnAnsHeight.constant = 40;
        }else{
            self.btnAnsHeight.constant = 0;
        }
        self.layoutIfNeeded();
        self.setNeedsLayout()
    }
    public func setResonseCell(isResponse : Bool) -> Void {

        self.isResponseCell = isResponse
        if( self.isResponseCell) {
             self.viewResponseBottom.isHidden = false
             self.btnAnsHeight.constant = 45;
            self.bringSubview(toFront: self.viewResponseBottom)
        }else{
             self.viewResponseBottom.isHidden = true
            if( self.isAnswer) {
                self.btnAnsHeight.constant = 40;
            }else{
                self.btnAnsHeight.constant = 0;
            }
        }
        self.layoutIfNeeded();
        self.setNeedsLayout()
    }
    
}

