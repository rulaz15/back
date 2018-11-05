//
//  ViewController.swift
//  QuickActions
//
//  Created by Raúl Torres on 07/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let icon = UIApplicationShortcutIcon(type: .alarm)
        let item = UIApplicationShortcutItem(type: "com.isa.QuickActions.adduser", localizedTitle: "Add User", localizedSubtitle: "Meet someone new", icon: icon, userInfo: nil)
        UIApplication.shared.shortcutItems = [item]
    }


}

