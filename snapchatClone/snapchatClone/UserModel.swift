//
//  UserModel.swift
//  snapchatClone
//
//  Created by Raúl Torres on 14/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import Foundation

class User {
    var email : String
    var uid : String
    
    init(email: String, uid: String) {
        self.email = email
        self.uid = uid
    }
}
