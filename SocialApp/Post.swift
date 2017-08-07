//
//  Post.swift
//  SocialApp
//
//  Created by Pragun Sharma on 04/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _imageURL: String!
    private var _numberOfLikes: Int!
    private var _postKey: String! //The ID
    
    var caption: String {
        return _caption
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var likes: Int {
        return _numberOfLikes
    }
    
    var postID: String {
        return _postKey
    }
    
    init(caption: String, imageURL: String, likes: Int) {
        
        self._caption = caption
        self._imageURL = imageURL
        self._numberOfLikes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        
        print(postData)
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageURL = postData["imageUrl"] as? String {
            self._imageURL = imageURL
        }
        
        if let likes = postData["likes"] as? Int {
            self._numberOfLikes = likes
        }
    }
    
}
