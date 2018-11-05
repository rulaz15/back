//
//  ViewController.swift
//  TestAccesoryInputView
//
//  Created by Raúl Torres on 09/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bottomC : NSLayoutConstraint?
    
    let bottomView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()
    
    let myToolbar : UIToolbar = {
        let tb = UIToolbar()
        tb.barTintColor = UIColor.red
        tb.items = [UIBarButtonItem(title: "Hello", style: .plain, target: self, action: nil)]
        tb.sizeToFit()
        return tb
    }()
    
    let myTextfield : UITextField = {
        let tf = UITextField()
        tf.placeholder = "olaaa :D"
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(bottomView)
        
        view.addContraintsWithFormat("H:|[v0]|", views: bottomView)
        view.addContraintsWithFormat("V:[v0(48)]", views: bottomView)
        
        bottomC = NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomC!)
        
       
        
        bottomView.addSubview(myTextfield)
        bottomView.addContraintsWithFormat("H:|-[v0]|", views: myTextfield)
        bottomView.addContraintsWithFormat("V:|[v0]|", views: myTextfield)
        myTextfield.inputAccessoryView = myToolbar
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomC?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
//            UIView.animate(withDuration: 0.0) {
//                self.view.layoutIfNeeded()
//            }
        }
    }
}

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

