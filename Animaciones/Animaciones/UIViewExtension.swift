//
//  UIViewExtension.swift
//  Animaciones
//
//  Created by Raúl Torres on 10/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

extension UIView {
    //MOVE
    func move(to destination: CGPoint, duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.center = destination
        }, completion: nil)
    }
    
    //ROTATE
    func rotate180(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }
    
    //ZOOM IN
    func addSubviewWithZoomInanimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions){
        view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
        addSubview(view)
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            view.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    //ZOOM OUT
    func removeWithZoomOutAnimation(duration: TimeInterval,
                                    options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    //FADE
    func addSubViewWithFadeAnimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions){
        view.alpha = 0.0
        addSubview(view)
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    
    //SKIN
    func removeWithSkinAnimation(steps: Int) {
        guard 1..<100 ~= steps else {
            fatalError("steps must be between 0 and 100")
        }
        tag = steps
        _ = Timer.scheduledTimer(
            timeInterval: 0.05,
            target: self,
            selector: #selector(removeWithSinkAnimationRotateTimer),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func removeWithSinkAnimationRotateTimer(timer: Timer) {
        // 1
        let newTransform = transform.scaledBy(x: 0.9, y: 0.9)
        // 2
        transform = newTransform.rotated(by: 0.314)
        // 3
        alpha *= 0.98
        // 4
        tag -= 1;
        // 5
        if tag <= 0 {
            timer.invalidate()
            removeFromSuperview()
        }
    }
    
    //CHANGE COLOR
    func changeColor(to color: UIColor, duration: TimeInterval, options: UIView.AnimationOptions){
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.backgroundColor = color
        }, completion: nil)
    }
}
