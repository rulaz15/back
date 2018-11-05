//
//  ViewController.swift
//  PushFun
//
//  Created by Raúl Torres on 15/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let url = URL(string: "http://fcm.googleapis.com/fcm/send") {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type":"application/json","Autorization":"key=AAAAX3KYHWw:APA91bGeVD0YIIEW3CQCnzmptVTmZ9y-6S4vuMJhIiWGYMm3GK42MLP-jbfWletyPJM0dIjbsYp-WcQ3jCHvePXYZnYpG4Wrnd_3wOLO9rQ63Z2GOm9fetIHHPRsvZ6g34Dy95VJ6DZ3rrXiQqeL00RANdLSwil_Tw"]
            
            request.httpMethod = "POST"
            request.httpBody = "{\"to\":\"ezDFXFCNoiI:APA91bEaJBsEfPECFA7nQfzmnulKPZUr-t3btcS5FGFCv5gl41nsd6glcK6SR3thYVnO3bLY8g3dc3_PW5ZVDV2G3J8boNDX8L38B7rK5L45NU3EZvTrJKa3xlbu6OsH-PJv5hiZm_gUB886960T67W7P1TlNWC7ug\",\"notification\":{\"title\":\"this is from http :D\"}}".data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print(String(data: data!, encoding: .utf8)!)
                }
            }
            task.resume()
        }
    }


}

