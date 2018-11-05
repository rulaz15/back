//
//  LoginViewController.swift
//  TinderClone
//
//  Created by Raúl Torres on 11/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    
    var signupMode = false
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var loginSignupBtn: UIButton!
    @IBOutlet var changeLoginSignupBtn: UIButton!
    
    @IBAction func loginSignupBtnAction(_ sender: Any) {
        if signupMode {
            let user = PFUser()
            user.username = usernameTF.text
            user.password = passwordTF.text
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    showAlert(title: "Whoops", message: error?.localizedDescription ?? "Try again", handler: nil, vc: self)
                    
                } else {
//                    showAlert(title: "hurray", message: "success", handler: nil, vc: self)
                    self.performSegue(withIdentifier: "updateSegue", sender: nil)
                }
            }
            
        } else {
            
            if let username = usernameTF.text, let password = passwordTF.text{
                PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                    if error != nil {
                        showAlert(title: "Whoops", message: error?.localizedDescription ?? "Try again", handler: nil, vc: self)
                        
                    } else {
//                        showAlert(title: "hurray", message: "success", handler: nil, vc: self)
//                        self.performSegue(withIdentifier: "updateSegue", sender: nil)
                        self.performSegue(withIdentifier: user?["isFemale"] != nil ? "loginToSwipingSegue" : "updateSegue", sender: nil)
                        
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func changeLoginSignupBtnAction(_ sender: Any) {
        
        if signupMode {
            loginSignupBtn.setTitle("Log In", for: .normal)
            changeLoginSignupBtn.setTitle("Sign Up", for: .normal)
        } else {
            loginSignupBtn.setTitle("Sign Up", for: .normal)
            changeLoginSignupBtn.setTitle("Log In", for: .normal)
        }
        
        signupMode = !signupMode
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            
//            if PFUser.current()?["isFemale"] != nil {
//                performSegue(withIdentifier: "loginToSwipingSegue", sender: nil)
//            } else {
//                performSegue(withIdentifier: "updateSegue", sender: nil)
//            }
            
            performSegue(withIdentifier: PFUser.current()?["isFemale"] != nil ? "loginToSwipingSegue" : "updateSegue", sender: nil)
            
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
