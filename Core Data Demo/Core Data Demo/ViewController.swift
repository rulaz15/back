//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
//
//        newUser.setValue("tommyy",forKey: "username")
//        newUser.setValue("pass",forKey: "password")
//        newUser.setValue(9, forKey: "age")
//
//        do {
//            try context.save()
//            print("saved")
//
//        } catch {
//            print("ocurrio un error al guardar")
//        }
//
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username = %@", "tommy")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            if !results.isEmpty {
                for r in results as! [NSManagedObject] {
                    if let username = r.value(forKey: "username") as? String {
                        print(username)
//                        context.delete(r)
                        
//                        r.setValue("dooley", forKey: "username")
//                        do {
//                            try context.save()
//                            print("saved")
//
//                        } catch {
//                            print("ocurrio un error al guardar")
//                        }
                    }
                }
            } else {
                print("resultados vacios")
            }
            
        } catch {
            print("error al traer los datos")
        }
    }
}

