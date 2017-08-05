//
//  DataService.swift
//  SocialApp
//
//  Created by Pragun Sharma on 04/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference() //Contain the url for our base of our database on firebase console
//We dont need to pull the url because it takes that info from the google.plist file

class DataService {
    
    static let dbs = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData) //If uid does not exists, Firebase will automatically create it (JUST WOW)
        
    }
    
    
}
