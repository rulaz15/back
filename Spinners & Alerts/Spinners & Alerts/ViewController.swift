//
//  ViewController.swift
//  Spinners & Alerts
//
//  Created by Raúl Torres on 09/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showAlertBtnaction(_ sender: Any) {
        let alertC = UIAlertController(title: "hello", message: ":p", preferredStyle: .alert)
        let alertA = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        let action2 = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alertC.addAction(alertA)
        alertC.addAction(action2)
        self.present(alertC, animated: true, completion: nil)
        
    }
    
    @IBAction func pauseAppBtnAction(_ sender: Any) {
        let actIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        actIndicator.center = self.view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.activityIndicatorViewStyle = .gray
        
        view.addSubview(actIndicator)
        
        actIndicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

