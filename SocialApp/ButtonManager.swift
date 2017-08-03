//
//  ButtonManager.swift
//  SocialApp
//
//  Created by Pragun Sharma on 02/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//
//To make a button circle
//1st Step = insert IBDesignable above class
//2nd Step = If you need a changeable value add that to ibinspectable 
//3rd step = layer.cornerRadius = your desired radius 
//A new way is shown below

import UIKit

class ButtonManager: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Shadow on Button
        layer.shadowColor = UIColor(colorLiteralRed: Float(SHADOW_GREY), green: Float(SHADOW_GREY), blue: Float(SHADOW_GREY), alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
        
    }
    
    
}

