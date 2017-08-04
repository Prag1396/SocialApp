//
//  FeedTableViewCell.swift
//  SocialApp
//
//  Created by Pragun Sharma on 04/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: ImageManager!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usrTxtField: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
