//
//  DriverTableViewController.swift
//  Uber Clone
//
//  Created by Raúl Torres on 26/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseDatabase
import MapKit

class DriverTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var riderRequest : [DataSnapshot] = []
    var locationManager = CLLocationManager()
    var driverLocation = CLLocationCoordinate2D()
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        do {
            try FUIAuth.defaultAuthUI()?.signOut()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Log out error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        Database.database().reference().child("RiderRequest").observe(.childAdded) { (snapshot) in
            
            if let rideRequestDictionary = snapshot.value as? [String:AnyObject] {
                if let lat = rideRequestDictionary["driverLat"] as? Double, let lon = rideRequestDictionary["driverLon"] as? Double {
                    
                } else {
                    self.riderRequest.append(snapshot)
                    self.tableView.reloadData()
                }
            }
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            self.tableView.reloadData()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = manager.location?.coordinate {
            driverLocation = coordinates
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return riderRequest.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let snapshot = riderRequest[indexPath.row]
        if let rideRequestDictionary = snapshot.value as? [String:AnyObject] {
            if let email = rideRequestDictionary["email"] as? String {
                
                if let lat = rideRequestDictionary["lat"] as? Double, let lon = rideRequestDictionary["lon"] as? Double {
                    
                    let driverCLlocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                    let riderCLlocation = CLLocation(latitude: lat, longitude: lon)
                    
                    let distance = driverCLlocation.distance(from: riderCLlocation) / 1000
                    let roundedDistance = round(distance * 100) / 100
                    
                    
                    cell.textLabel?.text = "\(email) - \(roundedDistance) km away"
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = riderRequest[indexPath.row]
        performSegue(withIdentifier: "acceptSegue", sender: snapshot)
    }


 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "acceptSegue" {
            let vc = segue.destination as? AcceptRequestViewController
            if let snapshot = sender as? DataSnapshot {
                if let rideRequestDictionary = snapshot.value as? [String:AnyObject] {
                    if let email = rideRequestDictionary["email"] as? String {
                        if let lat = rideRequestDictionary["lat"] as? Double, let lon = rideRequestDictionary["lon"] as? Double {
                            vc?.requestLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            vc?.requestEmail = email
                            vc?.driverlLocation = driverLocation
                        }
                    }
                }
            }
        }
    }
        
        
}
