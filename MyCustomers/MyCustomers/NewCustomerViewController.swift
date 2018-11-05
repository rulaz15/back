//
//  NewCustomerViewController.swift
//  MyCustomers
//
//  Created by Raúl Torres on 10/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import CoreData

class NewCustomerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        let insertAcuerdos = NSEntityDescription.insertNewObject(forEntityName: "Customers", into: context)
        
        insertAcuerdos.setValue(nameLabel.text, forKey: "customerName")
        
        do{
            
            try context.save()
        } catch {
            print("error guardar cliente")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
