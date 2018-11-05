//
//  MatchesViewController.swift
//  TinderClone
//
//  Created by Raúl Torres on 12/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController {
    
    var images = [UIImage]()
    var userIds = [String]()
    var messages = [String]()
    
    
    @IBOutlet var tableView: UITableView!
    @IBAction func backBarBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let query = PFUser.query() {
            query.whereKey("accepted", contains: PFUser.current()?.objectId)
            if let accepted = PFUser.current()?["accepted"] as? [String] {
                query.whereKey("objectId", containedIn: accepted)
                
                query.findObjectsInBackground { (objects, error) in
                    if let users = objects {
                        for object in users {
                            if let user = object as? PFUser {
                                if let imageFile = user["photo"] as? PFFile {
                                    imageFile.getDataInBackground(block: { (data, error) in
                                        if let imageData = data {
                                            if let image = UIImage(data: imageData) {
                                                
                                                if let objectID = user.objectId {
                                                   self.setArrays(objectID: objectID, image: image)
//                                                    let messagesQuery = PFQuery(className: "Message")
//                                                    messagesQuery.whereKey("recipient", equalTo: PFUser.current()?.objectId as Any)
//                                                    messagesQuery.whereKey("sender", equalTo: objectID)
//                                                    messagesQuery.findObjectsInBackground(block: { (newObjects, error) in
//                                                        var messageText = "no message from this user :("
//                                                        if let mesageObj = newObjects {
//                                                            for message in mesageObj {
//                                                                if let content = message["content"] as? String {
//                                                                    messageText = content
//                                                                }
//                                                            }
//                                                        }
//                                                        self.images.append(image)
//                                                        self.userIds.append(objectID)
//                                                        self.messages.append(messageText)
//                                                        self.tableView.reloadData()
//                                                    })
                                                
                                                }
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        
        }
    }

    func setArrays(objectID: String, image: UIImage){
        let messagesQuery = PFQuery(className: "Message")
        messagesQuery.whereKey("recipient", equalTo: PFUser.current()?.objectId as Any)
        messagesQuery.whereKey("sender", equalTo: objectID)
        messagesQuery.findObjectsInBackground(block: { (newObjects, error) in
            var messageText = "no message from this user :("
            if let mesageObj = newObjects {
                for message in mesageObj {
                    if let content = message["content"] as? String {
                        messageText = content
                    }
                }
            }
            self.images.append(image)
            self.userIds.append(objectID)
            self.messages.append(messageText)
            self.tableView.reloadData()
        })
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

extension MatchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MatchTableViewCell
        cell.recipient = userIds[indexPath.row]
        cell.messageLabel.text = messages[indexPath.row]
        cell.profileImageView.image = images[indexPath.row]
        return cell
    }
    
    
}

extension MatchesViewController:  UITableViewDelegate {
    
}
