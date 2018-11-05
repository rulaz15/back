//
//  NewProjectViewController.swift
//  MyCustomers
//
//  Created by Raúl Torres on 10/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import CoreData

class NewProjectViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var projectNameLabel: UITextField!
    @IBOutlet weak var dueDateDP: UIDatePicker!
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        let insertAcuerdos = NSEntityDescription.insertNewObject(forEntityName: "Acuerdos", into: context)
        
        insertAcuerdos.setValue(self.navigationController?.title, forKey: "customerName")
        insertAcuerdos.setValue(dueDateDP.date, forKey: "dueDate")
        insertAcuerdos.setValue(projectNameLabel.text, forKey: "projectName")
        
        do{
            try context.save()
            //print("Acuerdos guardado :D")
        } catch {
            print("error guardar proyecto")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let today = NSDate()
        dueDateDP.minimumDate = today as Date
        
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
