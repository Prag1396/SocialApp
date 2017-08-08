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
    @IBOutlet weak var likes_Icon: UIImageView!
    
    var post: Post!
    
    var likesRef: DatabaseReference!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likes_Icon.addGestureRecognizer(tap)
        likes_Icon.isUserInteractionEnabled = true
    }
    
    func likeTapped(_ sender: UITapGestureRecognizer) {
        
        likesRef.observeSingleEvent(of: .value, with: { (snapShot) in
            if let _ = snapShot.value as? NSNull {
                self.likes_Icon.image = UIImage(named: "filled-heart")
                self.post.setLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likes_Icon.image = UIImage(named: "empty-heart")
                self.post.setLikes(addLike: false)
                self.likesRef.removeValue()
            }
            
            })
    }
    
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        self.usrTxtField.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        likesRef = DataService.dbs.REF_USER_CURRENT.child("likes").child(post.postID)
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
        
        likesRef.observeSingleEvent(of: .value, with: { (snapShot) in
          
            if let _ = snapShot.value as? NSNull {
                self.likes_Icon.image = UIImage(named: "empty-heart")
            } else {
                self.likes_Icon.image = UIImage(named: "filled-heart")
            }
        })
        }
        
    }

