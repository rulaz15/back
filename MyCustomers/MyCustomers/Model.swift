//
//  Model.swift
//  MyCustomers
//
//  Created by Raúl Torres on 13/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import CoreData

@objc(Customers)
class Customers: NSManagedObject {
    @NSManaged var customerName : String
}
