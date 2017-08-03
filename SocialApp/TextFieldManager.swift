//
//  TextFieldManager.swift
//  SocialApp
//
//  Created by Pragun Sharma on 02/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit

class TextFieldManager: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(colorLiteralRed: Float(SHADOW_GREY), green: Float(SHADOW_GREY), blue: Float(SHADOW_GREY), alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
}
