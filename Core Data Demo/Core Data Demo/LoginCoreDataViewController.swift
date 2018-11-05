//
//  LoginCoreDataViewController.swift
//  Core Data Demo
//
//  Created by Raúl Torres on 03/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import CoreData

class LoginCoreDataViewController: UIViewController {

    var edit = false
    
    
    @IBOutlet var welcomeLabel: UILabel!
    
    @IBOutlet var userTF: UITextField!

    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var logoutBtn: UIButton!
    
    @IBAction func saveBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        user.setValue(userTF.text, forKey: "username")
        do {
            try context.save()
            welcomeLabel.text = "welcome "+userTF.text!
            welcomeLabel.isHidden = false
            userTF.isHidden = true
            loginBtn.isHidden = true
            editBtn.isHidden = false
            logoutBtn.isHidden = false
        } catch {
            print("ocurrio un error al guardar")
        }
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        
        
        
        if !edit {
            welcomeLabel.isHidden = true
            userTF.isHidden = false
            logoutBtn.isHidden = true
            loginBtn.isHidden = true
            editBtn.isHidden = false
            
            edit = true
            
        } else {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                if !results.isEmpty {
                    for r in results as! [NSManagedObject] {
                        r.setValue(userTF.text, forKey: "username")
                        
                        welcomeLabel.text = "welcome " + userTF.text!
                        
                        do {
                            try context.save()
                            userTF.isHidden = true
                            loginBtn.isHidden = true
                            welcomeLabel.isHidden = false
                            logoutBtn.isHidden = false
                            editBtn.isHidden = false
                            
                            edit = false
                        } catch {
                            print("ocurrio un error al guardar")
                        }
                    }
                }
            } catch {
                
            }
        }
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for r in results as! [NSManagedObject] {
                    context.delete(r)
                    do {
                        try context.save()
                        userTF.isHidden = false
                        loginBtn.isHidden = false
                        welcomeLabel.isHidden = true
                        logoutBtn.isHidden = true
                        editBtn.isHidden = true
                    } catch {
                        print("ocurrio un error al guardar")
                    }
                }
            }
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for r in results as! [NSManagedObject] {
                    if let user = r.value(forKey: "username") as? String{
                        //                        if user == userTF.text {
                        
                        userTF.isHidden = true
                        loginBtn.isHidden = true
                        logoutBtn.isHidden = false
                        editBtn.isHidden = false
                        welcomeLabel.isHidden = false
                        welcomeLabel.text = "welcome "+user
                        
                        break
                        //                        }
                    }
                }
            }
        } catch {
            
        }
        
    }
    


}
