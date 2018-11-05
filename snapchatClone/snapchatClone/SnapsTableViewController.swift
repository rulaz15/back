//
//  SnapsTableViewController.swift
//  snapchatClone
//
//  Created by Raúl Torres on 13/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {

    var dbRef : DatabaseReference!
    
    var snaps = [DataSnapshot]()
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        try? Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        
        if let currentUserUid = Auth.auth().currentUser?.uid {
        
            dbRef.child("users").child(currentUserUid).child("snaps").observe(.childAdded) { (snapshot) in
                self.snaps.append(snapshot)
                self.tableView.reloadData()
                
                self.dbRef.child("users").child(currentUserUid).child("snaps").observe(.childRemoved, with: { (snapshotRemoved) in

                    self.snaps.removeAll(where: {$0.key == snapshotRemoved.key})
                    
//                    for (i, snap) in self.snaps.enumerated() {
//                        if snapshotRemoved.key == snap.key {
//                            self.snaps.remove(at: i)
//                        }
//                    }
                    self.tableView.reloadData()
                })
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if snaps.isEmpty {
            return 1
        } else {
            return snaps.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        
        if snaps.isEmpty {
            cell.textLabel?.text = "no snaps 😔"
        } else {
            
            let snap = snaps[indexPath.row]
            
            if let snapDictionary = snap.value as? NSDictionary {
                if let fromEmail = snapDictionary["from"] as? String {
                    cell.textLabel?.text = fromEmail
                }
            }
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewSnapSegue", sender: snaps[indexPath.row])
        
    }

   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
            if let destCV = segue.destination as? ViewSnapViewController {
                destCV.snap = sender as? DataSnapshot
            }
        }
    }
}
