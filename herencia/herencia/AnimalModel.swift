//
//  AnimalModel.swift
//  herencia
//
//  Created by Raúl Torres on 24/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation

class Animal {
    let name: String
    var weight: Double
    var height: Double
    
    init(name: String, weight: Double, height: Double) {
        self.name = name
        self.weight = weight
        self.height = height
    }
    
    var description: String {
        return "The animal name is: \(self.name), weight: \(self.weight), height: \(self.height)"
    }
}

