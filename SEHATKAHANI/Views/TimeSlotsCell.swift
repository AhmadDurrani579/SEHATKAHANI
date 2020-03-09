//
//  TimeSlotsCell.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class TimeSlotsCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIViewX!
    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var outerView: UIViewX!
    @IBOutlet weak var sampleButton: UIButton!
    var onOff = true
    override func awakeFromNib() {
        super.awakeFromNib()
        viewHolder.layer.cornerRadius = viewHolder.frame.height / 2
      
        
    }
    func rip() {
          self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.outerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            self.outerView.transform = CGAffineTransform(scaleX: -1, y: -1)
            self.layoutIfNeeded()
        }
          self.layoutIfNeeded()
    }
    func rippleAffect() {
        let view = UIViewX(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.center = sampleButton.center
        view.layer.cornerRadius = view.frame.height / 2
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.4972877358)
        sampleButton.addSubview(view)
        
        UIViewX.animate(withDuration: 0.4, animations: {
            view.transform = CGAffineTransform(scaleX: 500, y: 500)
            view.alpha = 0
        }) { (true) in
            view.removeFromSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var closeHandler:(()-> Void)!
    @IBAction func actionButton(_ sender: Any) {
        print("yahoo")
        rippleAffect()
        if !onOff {
            radioButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            onOff = true

        }else {
           radioButton.backgroundColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
            onOff = false
            rip()

        }
    }
    
}
