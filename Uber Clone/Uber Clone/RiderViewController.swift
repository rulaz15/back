//
//  RiderViewController.swift
//  Bolts
//
//  Created by Raúl Torres on 26/07/18.
//

import UIKit
import MapKit
import FirebaseDatabase
import Firebase
import FirebaseDatabaseUI
import FirebaseAuthUI

class RiderViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var uberHasBeenCalled = false
    var driverLocation = CLLocationCoordinate2D()
    var driverOnTheWay = false
    
    @IBOutlet var callUberbtn: UIButton!
    @IBOutlet var map: MKMapView!
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        do {
            try FUIAuth.defaultAuthUI()?.signOut()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("Log out error")
        }
        
        
    }
    
    @IBAction func callUberBtnAction(_ sender: Any) {
        
        if !driverOnTheWay {
            if let currentUser = FUIAuth.defaultAuthUI()?.auth?.currentUser?.email {
                if uberHasBeenCalled {
                    uberHasBeenCalled = false
                    callUberbtn.setTitle("Call an Uber", for: .normal)
                    
                    Database.database().reference().child("RiderRequest").queryOrdered(byChild: "email").queryEqual(toValue: currentUser).observe(.childAdded) { (snapshot) in
                        snapshot.ref.removeValue()
                        Database.database().reference().child("RiderRequest").removeAllObservers()
                    }
                    
                } else {
                    
                    let rideRequestDisctionary : [String:Any] = ["email": currentUser, "lat": userLocation.latitude, "lon": userLocation.longitude]
                    Database.database().reference().child("RiderRequest").childByAutoId().setValue(rideRequestDisctionary)
                    
                    uberHasBeenCalled = true
                    callUberbtn.setTitle("Cancel Uber", for: .normal)
                }
            }
        } else {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let currentUser = FUIAuth.defaultAuthUI()?.auth?.currentUser?.email {
            Database.database().reference().child("RiderRequest").queryOrdered(byChild: "email").queryEqual(toValue: currentUser).observe(.childAdded) { (snapshot) in
                
                self.uberHasBeenCalled = true
                self.callUberbtn.setTitle("Cancel Uber", for: .normal)
                
                Database.database().reference().child("RiderRequest").removeAllObservers()
                
                if let rideRequestDictionary = snapshot.value as? [String:AnyObject] {
                    if let lat = rideRequestDictionary["driverLat"] as? Double, let lon = rideRequestDictionary["driverLon"] as? Double {
                        self.driverLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        self.driverOnTheWay = true
                        self.displayDriverAndRider()
                        
                        
                        if let currentUser = FUIAuth.defaultAuthUI()?.auth?.currentUser?.email {
                            Database.database().reference().child("RiderRequest").queryOrdered(byChild: "email").queryEqual(toValue: currentUser).observe(.childChanged) { (snapshot) in
                                if let rideRequestDictionary = snapshot.value as? [String:AnyObject] {
                                    if let lat = rideRequestDictionary["driverLat"] as? Double, let lon = rideRequestDictionary["driverLon"] as? Double {
                                        self.driverLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                        self.driverOnTheWay = true
                                        self.displayDriverAndRider()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func displayDriverAndRider() {
        let driverCLlocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
        let riderCLlocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        let distance = driverCLlocation.distance(from: riderCLlocation) / 1000
        let roundedDistance = round(distance * 100) / 100
        
        callUberbtn.setTitle("Your dirver is \(roundedDistance) km away!!", for: .normal)
        
        map.removeAnnotations(map.annotations)
        
        let latDelta = abs(driverLocation.latitude - userLocation.latitude) * 2 + 0.005
        let lonDelta = abs(driverLocation.longitude - userLocation.longitude) * 2 + 0.005
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        map.setRegion(region, animated: true)
        
        let riderAnnotation = MKPointAnnotation()
        riderAnnotation.coordinate = userLocation
        riderAnnotation.title = "Your location"
        map.addAnnotation(riderAnnotation)
        
        let driderAnnotation = MKPointAnnotation()
        driderAnnotation.coordinate = driverLocation
        driderAnnotation.title = "Your driver"
        map.addAnnotation(driderAnnotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = manager.location?.coordinate {
            let center = CLLocationCoordinate2D.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            
            userLocation = center

            if uberHasBeenCalled {
                displayDriverAndRider()
 
            } else {
                map.setRegion(region, animated: true)
                
                map.removeAnnotations(map.annotations)
                let anotation = MKPointAnnotation()
                anotation.coordinate = center
                anotation.title = "Your location"
                map.addAnnotation(anotation)
            }
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
