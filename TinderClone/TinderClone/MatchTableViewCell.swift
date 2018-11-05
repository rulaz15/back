//
//  MatchTableViewCell.swift
//  TinderClone
//
//  Created by Raúl Torres on 12/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse

class MatchTableViewCell: UITableViewCell {
    
    var recipient = String()
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageTF: UITextField!
    
    @IBAction func sendBtnAction(_ sender: Any) {
        let message = PFObject(className: "Message")
        message["sender"] = PFUser.current()?.objectId
        message["recipient"] = recipient
        message["content"] = messageTF.text
        
        message.saveInBackground()
        
        self.endEditing(true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
