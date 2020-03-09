//
//  CustomButton.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 04/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

}
import UIKit

@IBDesignable
class SPRadioButton: UIButton {
    
    @IBInspectable
    var gap:CGFloat = 8 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var btnColor: UIColor = UIColor.green{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var isOn: Bool = true{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .scaleAspectFill
        drawCircles(rect: rect)
    }
    
    
    //MARK:- Draw inner and outer circles
    func drawCircles(rect: CGRect){
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = 3
        circleLayer.strokeColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        circleLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(circleLayer)
        
        if isOn {
            let innerCircleLayer = CAShapeLayer()
            let rectForInnerCircle = CGRect(x: gap, y: gap, width: rect.width - 2 * gap, height: rect.height - 2 * gap)
            innerCircleLayer.path = UIBezierPath(ovalIn: rectForInnerCircle).cgPath
            innerCircleLayer.fillColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
            layer.addSublayer(innerCircleLayer)
        }
        self.layer.shouldRasterize =  true
        self.layer.rasterizationScale = UIScreen.main.nativeScale
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isOn = !isOn
        self.setNeedsDisplay()
    }
    
}
