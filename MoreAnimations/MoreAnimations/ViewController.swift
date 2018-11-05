//
//  ViewController.swift
//  MoreAnimations
//
//  Created by Raúl Torres on 13/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bgImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "captain"))
        return imageView
    }()
    
    let iconsContaitnerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        
//        let redView = UIView()
//        redView.backgroundColor = .red
//        let blueView = UIView()
//        blueView.backgroundColor = .blue
//
//        let arrangedSubviews = [redView,blueView]
        
        //configuration options
        let iconHeight : CGFloat = 30
        let padding : CGFloat = 5
        
        let images = [ UIImage(named: "like"), UIImage(named: "heart"), UIImage(named: "happy"), UIImage(named: "pirate"), UIImage(named: "unhappy"), UIImage(named: "angry")]
        
        let arrangedSubviews = images.map({ (image) -> UIView in
            
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = iconHeight / 2
            //requiered for hit testing
            imageView.isUserInteractionEnabled = true
            return imageView
            
//            let v = UIView()
//            v.backgroundColor = color
//            v.layer.cornerRadius = iconHeight / 2
//            return v
        })
        
        let stackV = UIStackView(arrangedSubviews: arrangedSubviews)
//        stackV.alignment = UIStackView.Alignment.fill
        stackV.distribution = .fillEqually
        
        
        stackV.spacing = padding
        stackV.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackV.isLayoutMarginsRelativeArrangement = true
        v.addSubview(stackV)
        
        let numIcons = CGFloat(stackV.arrangedSubviews.count)
        let width = numIcons * iconHeight + (numIcons + 1) * padding
        
        v.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        v.layer.cornerRadius = v.frame.height / 2
        
        //shadow
        v.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        v.layer.shadowRadius = 8
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackV.frame = v.frame
        return v
    }()
    
    override var prefersStatusBarHidden: Bool {return true}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(bgImageView)
        bgImageView.frame = self.view.frame
        
        setupLongPressGesture()
    
    }
    
    fileprivate func setupLongPressGesture() {
        self.view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }

    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
//        print("longpress:", Date())
        
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            //clean up the animation
            UIView.animate(withDuration:  0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContaitnerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                self.iconsContaitnerView.transform = self.iconsContaitnerView.transform.translatedBy(x: 0, y: self.iconsContaitnerView.frame.height)
                self.iconsContaitnerView.alpha = 0
            }, completion: { (_) in
                self.iconsContaitnerView.removeFromSuperview()
            })
            
        } else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
        }
    }
    
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressLocation = gesture.location(in: self.iconsContaitnerView)
        let fixedYLocation = CGPoint(x: pressLocation.x, y: self.iconsContaitnerView.frame.height / 2)
        let hitTestView = iconsContaitnerView.hitTest(fixedYLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration:  0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContaitnerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        self.view.addSubview(iconsContaitnerView)
        
        let pressLocation = gesture.location(in: self.view)
        
        //transformation of the red box
        let centeredX = (view.frame.width - iconsContaitnerView.frame.width) / 2
        iconsContaitnerView.transform =  CGAffineTransform(translationX: centeredX, y: pressLocation.y)

        //alpha 
        iconsContaitnerView.alpha = 0

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContaitnerView.alpha = 1
            self.iconsContaitnerView.transform = CGAffineTransform(translationX: centeredX, y: pressLocation.y - self.iconsContaitnerView.frame.height)
        })
    }

}

