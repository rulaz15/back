//
//  AlertClass.swift
//  Instagrama
//
//  Created by Raúl Torres on 10/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation
import UIKit


func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?, vc: UIViewController){
    let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Ok", style: .default, handler: handler)
    
    alertC.addAction(action1)
    vc.present(alertC, animated: true, completion: nil)
}
