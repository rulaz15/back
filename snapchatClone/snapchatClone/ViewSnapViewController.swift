//
//  ViewSnapViewController.swift
//  snapchatClone
//
//  Created by Raúl Torres on 14/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class ViewSnapViewController: UIViewController {

    var dbRef : DatabaseReference!
    var snap : DataSnapshot?
    var imageName : String?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var descriptonLabel: UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dbRef = Database.database().reference()
        
        if let snapDictionary = snap?.value as? NSDictionary {
            if let message = snapDictionary["description"] as? String, let imageUrl = snapDictionary["imageURL"] as? String {
                descriptonLabel.text = message
                imageView.sd_setImage(with: URL(string: imageUrl))
            }
            if let imageName = snapDictionary["imageName"] as? String {
                self.imageName = imageName
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if let currentUserUid = Auth.auth().currentUser?.uid {
            if let key = snap?.key {
                dbRef.child("users").child(currentUserUid).child("snaps").child(key).removeValue()
            }
            
            if let imageN = imageName {
                 Storage.storage().reference().child("images").child(imageN).delete(completion: nil)
            }
           
        }
    }

}
