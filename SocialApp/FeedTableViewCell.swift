//
//  FeedTableViewCell.swift
//  SocialApp
//
//  Created by Pragun Sharma on 04/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: ImageManager!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usrTxtField: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        self.usrTxtField.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        if img != nil {
            self.userImg.image = img
        } else {
                let ref = Storage.storage().reference(forURL: post.imageURL)
                ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    
                    if error != nil {
                        print("Pragun: Unable to download image from firebase storage")
                    } else {
                        print("Pragun: Image Downloaded from Firebase Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.userImg.image = img
                                FeedViewController.imageCache.setObject(img, forKey: post.imageURL as NSString)
                            }
                        }
                    }
                })
        }
        
        
    }
}
