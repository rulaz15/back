//
//  ViewController.swift
//  Swipes & Shakes
//
//  Created by Raúl Torres on 02/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
           
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: getSound()))
                player.play()
            } catch {
                
            }
        }
    }
    
    @objc func swiped(gesture : UIGestureRecognizer) {
        
        if let swipe = gesture as? UISwipeGestureRecognizer {
            switch swipe.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("swiped right")
            case UISwipeGestureRecognizer.Direction.left:
                print("swiped left")
            default:
                break
            }
        }
    }
    
    func getSound() -> String {
        let coin = Bundle.main.path(forResource: "bioshock_coin", ofType: ".mp3")
        let pacman = Bundle.main.path(forResource: "dead_pac_man", ofType: ".mp3")
        let marioW = Bundle.main.path(forResource: "mario_world", ofType: ".mp3")
        let mario = Bundle.main.path(forResource: "mario", ofType: ".mp3")
        let saria = Bundle.main.path(forResource: "saria", ofType: ".mp3")
        
        let sounds = [coin,pacman,marioW,mario,saria]
        
        let luckySound = Int.random(in: 0...sounds.count-1)
        print(luckySound)
        print(sounds.randomElement())
        return sounds[luckySound]!
    }

}

