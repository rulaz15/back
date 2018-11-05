//
//  ViewController.swift
//  TinderClone
//
//  Created by Raúl Torres on 11/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var displayUserId = ""

    @IBOutlet var matchImageView: UIImageView!
    
    @IBAction func logoutBarBtnAction(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var testing = PFObject(className:"Testing")
//        testing["test"] = "test"
//
//        testing.saveInBackground {
//            (success: Bool, error: Error?) in
//            if (success) {
//                // The object has been saved.
//                print("yeeiii")
//            } else {
//                // There was a problem, check error.description
//                print(error?.localizedDescription)
//            }
//        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDrag(gestureRecognizer:)))
        matchImageView.addGestureRecognizer(gesture)
        
        updateImage()
        
        PFGeoPoint.geoPointForCurrentLocation { (geopoint, error) in
            if let point = geopoint {
                PFUser.current()?["location"] = point
                PFUser.current()?.saveInBackground()
                
            }
        }
    }
    
    @objc func wasDrag(gestureRecognizer: UIPanGestureRecognizer){
        let point = gestureRecognizer.translation(in: self.view)
        matchImageView.center = CGPoint(x: view.bounds.width/2 + point.x, y: view.bounds.height/2 + point.y)
        
        let xFromCenter = view.bounds.width/2 - matchImageView.center.x
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        var scaleAndRotated = rotation.scaledBy(x: scale, y: scale)
        
        matchImageView.transform = scaleAndRotated
        
        if gestureRecognizer.state == .ended {
            
            var acceptedOrRejected = ""
            
            
            if matchImageView.center.x < (view.bounds.width/2 - 100) {
                print("not interested :v")
                acceptedOrRejected = "rejected"
            }
            
            if matchImageView.center.x > (view.bounds.width/2 + 100) {
                print("interested ;)")
                acceptedOrRejected = "accepted"
            }
            
            if acceptedOrRejected != "" && displayUserId != "" {
                PFUser.current()?.addUniqueObject(displayUserId, forKey: acceptedOrRejected)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if success {
                        self.updateImage()
                    }
                })
            }
            
            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            scaleAndRotated = rotation.scaledBy(x: 1, y: 1)
            matchImageView.transform = scaleAndRotated
            
            matchImageView.center = view.center
            
            
        }
    }
    
    func updateImage() {
        if let query = PFUser.query() {
            
            if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] {
                query.whereKey("isFemale", equalTo: isInterestedInWomen)
            }
            
            if let isFemale = PFUser.current()?["isFemale"] {
                query.whereKey("isInterestedInWomen", equalTo: isFemale)
            }
            
            var ignoredUsers = [String]()
            
            if let acceptedUsers = PFUser.current()?["accepted"] as? [String] {
                 ignoredUsers += acceptedUsers
            }
            
            if let rejectedUsers = PFUser.current()?["rejected"] as? [String] {
                ignoredUsers += rejectedUsers
            }
            
            query.whereKey("objectId", notContainedIn: ignoredUsers)
            
            if let geoPoint = PFUser.current()?["location"] as? PFGeoPoint {
                query.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: geoPoint.latitude - 1, longitude: geoPoint.longitude - 1), toNortheast: PFGeoPoint(latitude: geoPoint.latitude + 1, longitude: geoPoint.longitude + 1))
            }
            
            
            
            query.limit = 1
            query.findObjectsInBackground { (objects, error) in
                if let users = objects {
                    for object in users {
                        if let user = object as? PFUser {
                            if let imageFile = user["photo"] as? PFFile {
                                imageFile.getDataInBackground(block: { (data, error) in
                                    if let imageData = data {
                                        let image = UIImage(data: imageData)
                                        self.matchImageView.image = image
                                        if let objectID = object.objectId {
                                            self.displayUserId = objectID
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

