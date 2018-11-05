//
//  ViewController.swift
//  Brown Dog
//
//  Created by Raúl Torres on 08/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        INPreferences.requestSiriAuthorization { (status) in
            if status == INSiriAuthorizationStatus.authorized {
                print("we can use siri")
            } 
        }
    }


}

