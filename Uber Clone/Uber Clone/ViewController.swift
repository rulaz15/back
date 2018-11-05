//
//  ViewController.swift
//  Uber Clone
//
//  Created by Raúl Torres on 26/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI

class ViewController: UIViewController {
    
    var signUpMode = true
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var riderDriverSwitch: UISwitch!
    @IBOutlet var riderLabel: UILabel!
    @IBOutlet var driverLabel: UILabel!
    
    @IBOutlet var topBtn: UIButton!
    @IBOutlet var bottomBtn: UIButton!
    
    
    @IBAction func topBtnAction(_ sender: Any) {
        if (emailTF.text?.isEmpty)! || (passwordTF.text?.isEmpty)! {
            displayAlert(title: "Missing information", msg: "provide email and password")
        } else {
            
            if let email = emailTF.text, let password = passwordTF.text {

                if signUpMode {
                    //SIGN UP
                    FUIAuth.defaultAuthUI()?.auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", msg: error!.localizedDescription)
                        } else {
                           
                            if self.riderDriverSwitch.isOn {
                                //DRIVER
                                let req = FUIAuth.defaultAuthUI()?.auth?.currentUser?.createProfileChangeRequest()
                                req?.displayName = "Driver"
                                req?.commitChanges(completion: nil)
                                self.goToMainDriver()
                                
                            } else {
                                //RIDER
                                let req = FUIAuth.defaultAuthUI()?.auth?.currentUser?.createProfileChangeRequest()
                                req?.displayName = "Rider"
                                req?.commitChanges(completion: nil)
                                self.goToMainRider()
                            }
                        }
                        
                    })
                } else {
                    // LOG IN
                    
                    FUIAuth.defaultAuthUI()?.auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", msg: error!.localizedDescription)
                        } else {

                            if user?.displayName == "Driver" {
                                //DRIVER
                                print("DRIVER")
                                self.goToMainDriver()
                            } else {
                                //RIDER
                                self.goToMainRider()
                            }
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func bottomBtnAction(_ sender: Any) {
        if signUpMode {
            topBtn.setTitle("Log in", for: .normal)
            bottomBtn.setTitle("Switch to Sign Up", for: .normal)
            
            riderLabel.isHidden = true
            driverLabel.isHidden = true
            riderDriverSwitch.isHidden = true
   
        } else {
            topBtn.setTitle("Sign Up", for: .normal)
            bottomBtn.setTitle("Switch to Log in", for: .normal)
            
            riderLabel.isHidden = false
            driverLabel.isHidden = false
            riderDriverSwitch.isHidden = false
        }
        signUpMode = !signUpMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func goToMainRider(){
        performSegue(withIdentifier: "riderSegue", sender: nil)
    }
    
    func goToMainDriver(){
        performSegue(withIdentifier: "driverSegue", sender: nil)
    }

    func displayAlert(title: String, msg: String) {
        let alertC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertA = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertC.addAction(alertA)
        present(alertC, animated: true, completion: nil)
    }

}

