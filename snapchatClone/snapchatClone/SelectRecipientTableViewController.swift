//
//  SelectRecipientTableViewController.swift
//  snapchatClone
//
//  Created by Raúl Torres on 14/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectRecipientTableViewController: UITableViewController {
    
    
    var dbRef: DatabaseReference!
    var downloadURL = String()
    var message = String()
    var users = [User]()
    var imageName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        dbRef.child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    let user = User(email: email, uid: snapshot.key)
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        if let fromEmail = Auth.auth().currentUser?.email {
            let snap = ["from": fromEmail, "description": message, "imageURL": downloadURL, "imageName": imageName]
            
            dbRef.child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
            
            navigationController?.popToRootViewController(animated: true)
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
