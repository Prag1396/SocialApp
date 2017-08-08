//
//  FeedViewController.swift
//  SocialApp
//
//  Created by Pragun Sharma on 03/08/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captionTextField: TextFieldManager!
    @IBOutlet weak var addImage: ImageManager!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        captionTextField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.dbs.REF_POSTS.observe(.value, with: { (snapshot) in
            //Parsing firebase data
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP KEY: \(snap.key)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> { //snap.value return a dictionary, snap itself is an object
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
    
    @IBAction func signOutBtnTapped(_ sender: AnyObject) {
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Pragun: ID Removed from Keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "toSignIn", sender: nil)
    }
    
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func postBtnTapped(_ sender: UIButton) {
        
        guard let caption = captionTextField.text, caption != "" else { //If the conditions are not met then the program counter goes to the 
            //If it lands here then it means caption = ""               //else statement body
            print("Pragun: Caption must be entered")
            return
        }
        
        guard let img = addImage.image, imageSelected == true else {
            print("Pragun: An Image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            DataService.dbs.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metaData) { (metadata, error) in
            
                if error != nil {
                    print("Pragun: Unable to upload image to firebase")
                } else {
                    print("Pragun: Successfully uploaded image to firebase")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        print("here again")
                         self.postToFirebase(imgUrl: url)
                    }
                   
                    
                }
            }
        }
    }
    
    func postToFirebase(imgUrl: String) {
        let post: Dictionary<String, AnyObject> = [
            "caption": captionTextField.text! as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject
        ]
        
        let firebasePost = DataService.dbs.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionTextField.text = ""
        imageSelected = false
        addImage.image = UIImage(named: "add-image")
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedTableViewCell {
            
            if let img = FeedViewController.imageCache.object(forKey: post.imageURL as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
             
                cell.configureCell(post: post)
                return cell
            }
            
        } else {
            
            return FeedTableViewCell()
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
            imageSelected = true
        } else {
            print("Pragun: An invalid image was selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
