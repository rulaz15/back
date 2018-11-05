//
//  ViewController.swift
//  FBLoginTest
//
//  Created by Raúl Torres on 07/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
 
 

    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile","email"]
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        } else {
            if result.isCancelled {
                print("canceled :(")
            }else {
                if result.grantedPermissions.contains("email") {
                    if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
                        graphRequest.start { (connection, result, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else {
                                if let userDets = result {
                                    print(userDets)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }
    


}

