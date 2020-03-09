//
//  waitingForDoctor.swift
//  Sehat Kahani
//
//  Created by M Abubaker Majeed on 27/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class waitingForDoctor: UIView {

    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewCenteral: UIView!
    @IBOutlet var viewtimer: UIView!
    @IBOutlet var expandingView: UIView!


    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    func rippleAffect() {
        let view = UIViewX(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.center = viewtimer.center
        view.layer.cornerRadius = view.frame.height / 2
        view.backgroundColor = #colorLiteral(red: 0.9257782268, green: 0, blue: 0.3385027924, alpha: 1)
        viewCenteral.addSubview(view)
        
        UIViewX.animate(withDuration: 0.6, animations: {
            view.transform = CGAffineTransform(scaleX: 190, y: 190)
            view.alpha = 0
        }) { (true) in
            view.removeFromSuperview()
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.addGestureRecognizer(tap)

    }
    @objc func handleTap() {
       self.removeFromSuperview();
    }

    override func draw(_ rect: CGRect) {
        self.viewCenteral.layer.cornerRadius = 15;
        self.viewtimer.layer.cornerRadius = self.viewtimer.frame.size.height/2;

    }

}
