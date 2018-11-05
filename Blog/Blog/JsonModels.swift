//
//  JsonModels.swift
//  Blog
//
//  Created by Raúl Torres on 04/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation

struct GoogleBlog : Decodable {
//    var kind : String?
//    var nextPageToken : String?
    var items : [BlogItems]
    
}

struct BlogItems : Decodable {
    var kind : String?
    var id: String?
    var blog : BlogBlog
    var published : String
    var title : String
    var content : String
}

struct BlogBlog : Decodable{
    var id: String
}
