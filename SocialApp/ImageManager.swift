//
//  ImageManager.swift
//  SocialApp
//
//  Created by Pragun Sharma on 03/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit

class ImageManager: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(colorLiteralRed: Float(SHADOW_GREY), green: Float(SHADOW_GREY), blue: Float(SHADOW_GREY), alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
        
    }

}
