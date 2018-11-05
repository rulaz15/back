//
//  ViewController.swift
//  Animaciones
//
//  Created by Raúl Torres on 10/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let colors: [UIColor] = [.white, .red, .green, .orange, .yellow, .lightGray, .darkGray]
    
    var skinV : UIView!
    
    @IBOutlet var zoomView: ZView!
    @IBOutlet var btnMove: UIButton!
    
    @IBAction func btnMoveAction(_ sender: UIButton) {
        btnMove.rotate180(duration: 1.0, options: .curveEaseInOut)
    }
    
    @IBAction func moveHere1(_ sender: UIButton) {
        let destination = view.convert(sender.center, to: sender.superview)
        btnMove.move(to: destination.applying(CGAffineTransform(translationX: 0.0, y: -50.0)),
                     duration: 1.0,
                     options: .curveEaseInOut)
    }
    
    @IBAction func showHUD(_ sender: UIButton) {
        let skinV = zoomView!
        skinV.frame = CGRect(x: 0, y: 0, width: 280, height: 300)
        skinV.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        skinV.closeBtn.addTarget(self, action: #selector(closeSkin), for: .touchUpInside)
        self.view.addSubViewWithFadeAnimation(skinV, duration: 1.0, options: .curveEaseInOut)
        
    }
    
    @IBAction func changeTiming(_ sender: Any) {
//        let vc = ZoomViewController()
//
//        vc.view.bounds = CGRect(x: 0, y: 0, width: 280, height: 300)
//        vc.view.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
//
//        self.addChild(vc)
//        self.view.addSubviewWithZoomInanimation(vc.view, duration: 1.0, options: .curveEaseInOut)
//        vc.didMove(toParent: self)
        zoomView.frame = CGRect(x: 0, y: 0, width: 280, height: 300)
        zoomView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        zoomView.closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.view.addSubviewWithZoomInanimation(zoomView, duration: 1.0, options: .curveEaseInOut)
    }
    
    @IBAction func changeColor(_ sender: Any) {
        self.view.changeColor(to: colors.randomElement()!, duration: 1.0, options: .curveEaseInOut)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        skinV = zoomView
    }

    @objc func close() {
        zoomView.removeWithZoomOutAnimation(duration: 1.0, options: .curveEaseInOut)
    }
    
    @objc func closeSkin(){
        skinV.removeWithSkinAnimation(steps: 75)
    }

}

