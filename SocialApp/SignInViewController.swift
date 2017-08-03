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


class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwrdTextField: TextFieldManager!
    @IBOutlet weak var emailAddressTxtField: TextFieldManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwrdTextField.delegate = self
        emailAddressTxtField.delegate = self
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
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Pragun: Unable to authenticate with Firebase Using Email")
                        } else {
                            print("Pragun: Successfully Authenticated with Firebase using Email")
                        }
                    })
                }
            })
        }
    }
    
    

}

