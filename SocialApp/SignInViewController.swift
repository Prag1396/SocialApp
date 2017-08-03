//
//  ViewController.swift
//  SocialApp
//
//  Created by Pragun Sharma on 02/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase


class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func authFirebase(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Pragun: Unable to authenticate with Firebase. \(error.debugDescription)")
            } else {
                print("Pragun: Successfully Authenticated with Firebase")
            }
        }
    }

    @IBAction func facebookButtonPressed(_ sender: Any) {
        
        let faceBookLogin = FBSDKLoginManager()
        faceBookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if(error != nil) {
                print("Pragun: Unable to authenticate with Facebook \(error.debugDescription)")
            } else if result?.isCancelled == true {
                print("Pragun: User Cancelled Facebook Authentication")
            } else {
                print("Pragun: Sucessfully Authenticaated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.authFirebase(credential)
            }
        }
    }

}

