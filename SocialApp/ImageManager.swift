//
//  ImageManager.swift
//  SocialApp
//
//  Created by Pragun Sharma on 03/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit

class ImageManager: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
    }

}
