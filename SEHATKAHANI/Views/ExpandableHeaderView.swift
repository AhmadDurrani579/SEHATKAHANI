//
//  ExpandableHeaderView.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 03/01/2018.
//  Copyright © 2018 M Zia Ur Rehman Ch. All rights reserved.
//


import UIKit

protocol ExpandableHeaderViewDelegate {
    
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
        
    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = #colorLiteral(red: 0.00471113855, green: 0.7051281333, blue: 0.5874349475, alpha: 1)
        self.textLabel?.font = UIFont(name: "Lato", size: 16)
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundView?.backgroundColor = UIColor.clear
        let xView = UIViewX()
        xView.frame = CGRect(x: 20, y: 2, width: self.frame.width - 40, height: 40)
        xView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        xView.shadowOpacity = 1
        xView.shadowColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.2041568396)
        xView.shadowOffsetY = 0
//        xView.shadowRadius = 2
        backgroundView?.addSubview(xView)
        self.textLabel?.frame.origin.x = 20
        self.contentView.frame = CGRect(x: 20, y: 1, width: self.frame.width - 40, height: 42)
      
//        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
    }
    
}

