//
//  AddViewWithConstraintsExtension.swift
//  MyScan
//
//  Created by Raúl Torres on 17/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
extension UIView {
    func addContraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewDict))
    }
}
