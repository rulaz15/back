//
//  UserTableViewController.swift
//  Bolts
//
//  Created by Raúl Torres on 10/07/18.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {

    
    var refresher : UIRefreshControl = UIRefreshControl()
    
    var usernames = [String]()
    var objectsIds = [String]()
    var isFollowing = [String:Bool]()
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       
        updateTable()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(updateTable), for: .valueChanged)
     
        tableView.addSubview(refresher)
    }
    
    
    @objc func updateTable() {
        let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        query?.findObjectsInBackground(block: { (users, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            } else if let users = users {
                for object in users {
                    if let user = object as? PFUser {
                        
                        if let username = user.username, let objectId = user.objectId {
                            
                            self.usernames.append(username.components(separatedBy: "@")[0])
                            self.objectsIds.append(objectId)
                            
                            let query = PFQuery(className: "Following")
                            query.whereKey("follower", equalTo: PFUser.current()?.objectId)
                            query.whereKey("following", equalTo: objectId)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                if let objects = objects {
                                    
                                    self.isFollowing[objectId] = objects.isEmpty ? false : true
                                    
                                    //                                    if !objects.isEmpty {
                                    //                                        self.isFollowing[objectId] = true
                                    //
                                    //                                    } else {
                                    //                                        self.isFollowing[objectId = false
                                    //                                    }
                                    
                                    if self.usernames.count == self.isFollowing.count {
                                        self.tableView.reloadData()
                                        self.refresher.endRefreshing()
                                    }
                                }
                            })
                        }
                    }
                }
                
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

       cell.textLabel?.text = usernames[indexPath.row]
        
        if let followsBoolean = isFollowing[objectsIds[indexPath.row]] {
            if followsBoolean {
                cell.accessoryType = .checkmark
            }
        }
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = .checkmark
        
        
        if let followsBoolean = isFollowing[objectsIds[indexPath.row]] {
            if followsBoolean {
                
                isFollowing[objectsIds[indexPath.row]] = false
                
                cell?.accessoryType = .none
                
                let query = PFQuery(className: "Following")
                query.whereKey("follower", equalTo: PFUser.current()?.objectId)
                query.whereKey("following", equalTo: objectsIds[indexPath.row])
                
                query.findObjectsInBackground(block: { (objects, error) in
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackground()
                        }
                    }
                })
            } else {
                
                isFollowing[objectsIds[indexPath.row]] = false
                cell?.accessoryType = .checkmark
                let following = PFObject(className: "Following")
                following["follower"] = PFUser.current()?.objectId
                following["following"] = objectsIds[indexPath.row]
                
                following.saveInBackground()
            }
        }
    
}


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
