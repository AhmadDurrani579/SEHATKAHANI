//
//  BlackAndPopUPViews.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 16/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import Foundation

class BlackAndPopUPViews: UIButton {
  
    var fr: CGRect!
    var myNewView: ButtonAction!
//    let fra: CGRect! = nil
    
    func BlackPopup(popView: UIView, addButton: ViewHolder)  {
        let window = UIApplication.shared.keyWindow!
        
        myNewView = ButtonAction(frame: CGRect(x: 0, y: 0, width: (window.frame.width), height: window.frame.height))
        myNewView.backgroundColor=UIColor.black
        myNewView.alpha = 0
        myNewView.isUserInteractionEnabled = true
        window.addSubview(myNewView)
        popView.frame = CGRect(x: (window.frame.width - popView.frame.width) / 2, y: 0, width: window.frame.width / 1.15, height: window.frame.height / 2 + 30)
        popView.frame.origin.y = myNewView.frame.height
        popView.frame.origin.x = (myNewView.frame.width - popView.frame.width) / 2
        fr = popView.frame
        UIView.animate(withDuration: 0.5, animations: {
            self.myNewView.alpha = 0.5
        }) { (true) in
            window.addSubview(popView)
            popView.xView(value: 15)
            addButton.cornerRaduis()
            UIView.animate(withDuration: 0.3, animations: {
                popView.frame.origin.y = (self.myNewView.frame.height - popView.frame.height) + 30
            })
        }
    }

    func close(popView: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            popView.frame = self.fr
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.myNewView.alpha = 0
            }, completion: { (true) in
                self.myNewView.removeFromSuperview()
            })
        }
    }
    
    
    func moveViewUp(view: UIView){
    }

    func playTapped() {
        print(1234)
    }
    
    
}
//class CurvedView: UIView {
//    override func draw(_ rect: CGRect) {
//        let y:CGFloat = rect.height - 50
//        //        let curveTo:CGFloat = 0
//
//        let myBezier = UIBezierPath()
//        myBezier.move(to: CGPoint(x: 0, y: y))
//        myBezier.addQuadCurve(to: CGPoint(x: rect.width, y: y), controlPoint: CGPoint(x: rect.width / 2, y: rect.height))
//        myBezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
//        myBezier.addLine(to: CGPoint(x: 0, y: rect.height))
//        myBezier.close()
//        let context = UIGraphicsGetCurrentContext()
//        context!.setLineWidth(10.0)
//        #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).setFill()
//
//        myBezier.fill()
//    }
//}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        
        let y:CGFloat = 0
        let curveTo:CGFloat = rect.height * 2
        
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: -(rect.width + (rect.width / 2)), y: y))
        myBezier.addQuadCurve(to: CGPoint(x: (rect.width * 2) + (rect.width / 2), y: y), controlPoint: CGPoint(x: rect.width / 2, y: curveTo))
        
//        myBezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
//        myBezier.addLine(to: CGPoint(x: 0, y: rect.height))
        myBezier.close()
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(10.0)
        #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1).setFill()
        myBezier.fill()
    }
}

















