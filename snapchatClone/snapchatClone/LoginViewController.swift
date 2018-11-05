//
//  ViewController.swift
//  snapchatClone
//
//  Created by Raúl Torres on 13/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var dbRef: DatabaseReference!
    
    var signUpMode = false
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var topBtn: UIButton!
    @IBOutlet var bottomBtn: UIButton!
    
    @IBAction func topBtnAction(_ sender: Any) {
        
        if let email = emailTF.text, let password = passwordTF.text {
        
            if signUpMode {
                //sign up
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.showAlert(msg: error.localizedDescription)
                    } else {
                        if let user = user {
                            self.dbRef.child("users").child(user.user.uid).child("email").setValue(user.user.email)
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    }
                }
            } else {
                //log in
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                       self.showAlert(msg: error.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                    }
                }
            }
            signUpMode = !signUpMode
        }
    }
    
    @IBAction func bottomBtnAction(_ sender: Any) {
        if signUpMode {
            //switch to log in
            topBtn.setTitle("Log In", for: .normal)
            bottomBtn.setTitle("Switch to Sign Up", for: .normal)
        } else {
            //switch to sign up
            topBtn.setTitle("Sign Up", for: .normal)
            bottomBtn.setTitle("Switch to Log In", for: .normal)
        }
        signUpMode = !signUpMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dbRef = Database.database().reference()
    }

    func showAlert(msg: String) {
        let alertC = UIAlertController(title: "error", message: msg, preferredStyle: .alert)
        let alertA = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertC.addAction(alertA)
        self.present(alertC, animated: true, completion: nil)
    }

}

