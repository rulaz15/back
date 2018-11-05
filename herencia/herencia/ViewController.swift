//
//  ViewController.swift
//  herencia
//
//  Created by Raúl Torres on 24/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    typealias intFunc = (Int) -> Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bowser = Animal(name: "bowser", weight: 30.2, height: 20.4)
        print(bowser.description)
//        let spot = Dog(owner: "Yoni", animal: Animal(name: "spot", weight: 10.4, height: 11.1))
        let spot = Dog(owner: "yoni", name: "spot", weight: 10.4, height: 11.1)
        print(spot.description)
        
// CURRYING FUNCTIONS
        let suma = sumar(x: 2)(3)
        let resultado1 = suma(3)
        let suma5 = sumar(x: 5)
        let suma5y2 = suma5(2)
        let resultado2 = suma5y2(3)
        
//        let suma = sumar(2)(y: 3)
//        let resultado1 = suma(z: 3)
//        let suma5 = sumar(5)
//        let suma5y2 = suma5(y:2)
//        let resultado2 = suma5y2(z:3)
        print("""
            suma: \(suma)
            resultado1:\(resultado1)
            suma5: \(suma5)
            resultado2: \(resultado2)
            \(sumar(x: 2)(2)(2))
            """)
        showAlert(mytitle: "titulo", myMsg: "msg")
    }


    func sumar(x:Int)->(Int)->(Int) -> Int {
        
        return {(y: Int) -> (Int) -> Int in
            return { z -> Int in
                return x + y + z
            }
        }
        
//        return x + y + z
    }
    
    func curried(x: Int) -> (String) -> Float {
        return {(y: String) -> Float in
            return Float(x) + Float(y)!
        }
    }
    
    //snippet alert
    func showAlert(mytitle title: String, myMsg msg: String) {
        let alertC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertA = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertC.addAction(alertA)
        self.present(alertC, animated: true, completion: nil)
    }
}

