//
//  JsonModels.swift
//  APIDemo
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation

struct MainInfo : Codable {
    var humidity : Int
    var preasure : Int
    var temp : String
    
}

struct CityName : Codable {
    var name : String
}

struct Weateher : Codable {
    var description : String
}

struct InfoWeather : Codable {
    var main : MainInfo
    var name : CityName
    var weather : Weateher
}

struct AllJson : Codable {
    var coord : nose?
}

struct nose : Codable {
    var lon : Int?
    var lat : Int?
}
