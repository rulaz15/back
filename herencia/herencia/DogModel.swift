//
//  DogModel.swift
//  herencia
//
//  Created by Raúl Torres on 24/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation

class Dog : Animal {
    
    var owner: String
    
    init(owner: String, animal : Animal) {
        self.owner = owner
        super.init(name: animal.name, weight: animal.weight, height: animal.height)
    }
    
    convenience init(owner: String, name: String, weight: Double, height: Double) {
        let animal = Animal(name: name, weight: weight, height: height)
        self.init(owner: owner, animal: animal)
    }
    
    override var description: String {
        return super.description + ", owner: \(owner)"
    }
}
