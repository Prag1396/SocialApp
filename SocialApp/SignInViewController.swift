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
import SwiftKeychainWrapper

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwrdTextField: TextFieldManager!
    @IBOutlet weak var emailAddressTxtField: TextFieldManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwrdTextField.delegate = self
        emailAddressTxtField.delegate = self
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //If the user has successfully created an account
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "toFeed", sender: nil)
        }
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func authFirebase(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Pragun: Unable to authenticate with Firebase. \(error.debugDescription)")
            } else {
                print("Pragun: Successfully Authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
    func completeSignIn(id: String) {
       let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Pragun: Data Svaed to Keychain \(keyChainResult)")
        performSegue(withIdentifier: "toFeed", sender: nil)

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
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        
        if let email = emailAddressTxtField.text, let pwd = passwrdTextField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Pragun: Email User authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Pragun: Unable to authenticate with Firebase Using Email")
                        } else {
                            print("Pragun: Successfully Authenticated with Firebase using Email")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    

}

