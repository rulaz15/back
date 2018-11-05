//
//  InterfaceController.swift
//  WatchApp1 Extension
//
//  Created by Raúl Torres on 03/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var number = 0
    
    @IBOutlet var myLabel: WKInterfaceLabel!
    
    @IBAction func upBtnAction() {
        number += 1    
        updateMyLabel()
    }
    
    @IBAction func downBtnAction() {
        number -= 1
        updateMyLabel()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateMyLabel()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateMyLabel(){
        self.myLabel.setText("\(number)")
    }

}
