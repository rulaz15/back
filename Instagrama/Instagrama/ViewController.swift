//
//  ViewController.swift
//  Instagrama
//
//  Created by Raúl Torres on 09/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    let actIndicator = UIActivityIndicatorView()
    
    var signUpModeActive = true
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var switchLoginBtn: UIButton!
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        //        TODO:- Validar campos no vacios y validos
        if !((emailTF.text?.isEmpty)!) && !((passwordTF.text?.isEmpty)!) {
            
            showActIndicator(show: true)
            
            if signUpModeActive {
                signUp(username: emailTF.text!, pass: passwordTF.text!)
            } else {
        
                PFUser.logInWithUsername(inBackground: emailTF.text!, password: passwordTF.text!) { (user, error) in
                    
                    self.showActIndicator(show: false)
                    
                    if user != nil {
                        print("login ok")
                         self.performSegue(withIdentifier: "showUserTable", sender: self)
                    } else {
                        var errorText = ":("
                        
                        if let error = error {
                            errorText = error.localizedDescription
                        }
                        
                        showAlert(title: "noup", message: errorText, handler: nil, vc: self)
                    }
                }
            }
        } else {
            showAlert(title: "Error", message: "Fill all parameters", handler: nil, vc: self)
        }
    }
    
    @IBAction func switchLoginModeBtnAction(_ sender: Any) {
        if signUpModeActive {
            signUpModeActive = false
            signUpBtn.setTitle("Log in", for: .normal)
            switchLoginBtn.setTitle("Sign up", for: .normal)
            
        } else {
            signUpModeActive = true
            signUpBtn.setTitle("Sign up", for:.normal)
            switchLoginBtn.setTitle("Log in", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        actIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        actIndicator.center = self.view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.style = .gray
        view.addSubview(actIndicator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
             self.performSegue(withIdentifier: "showUserTable", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func signUp(username: String, pass: String) {
        let user = PFUser()
        user.username = username
        user.password = pass
        user.email = username
        // other fields can be set just like with PFObject
        //        user["phone"] = "415-392-0202"
        
        user.signUpInBackground { (success, error) in
            
            self.showActIndicator(show: false)
            
            if let error = error {
//                let errorString = error._userInfo!["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
//                print(errorString)
                showAlert(title: "Error", message: error.localizedDescription, handler: nil, vc: self)
            } else {
                // Hooray! Let them use the app now.
                
                showAlert(title: "Hooray!", message: "registration successful", handler: { (_) in
                     self.performSegue(withIdentifier: "showUserTable", sender: self)
                }, vc: self)
            }
        }
        
    }
    

    
    func showActIndicator(show: Bool) {
        if show {
            actIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            actIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}

