//
//  AcceptRequestViewController.swift
//  Uber Clone
//
//  Created by Raúl Torres on 27/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class AcceptRequestViewController: UIViewController {
    
    var requestLocation = CLLocationCoordinate2D()
    var requestEmail = String()
    var driverlLocation = CLLocationCoordinate2D()

    @IBOutlet var map: MKMapView!
    
    @IBAction func acceptRequestBtnAction(_ sender: Any) {
        //UPDATE THE RIDE REQEUST
        Database.database().reference().child("RiderRequest").queryOrdered(byChild: "email").queryEqual(toValue: requestEmail).observe(.childAdded) { (snapshot) in
            
            snapshot.ref.updateChildValues(["driverLat": self.driverlLocation.latitude, "driverLon":self.driverlLocation.longitude])
            
            Database.database().reference().child("RiderRequest").removeAllObservers()
            
        }
        
        //GIVE DIRECTIONS
        let requestCLlocation = CLLocation(latitude: requestLocation.latitude, longitude: requestLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(requestCLlocation) { (placemarks, error) in
            if let placemarks = placemarks {
                if !placemarks.isEmpty {
                    let placeMark = MKPlacemark(placemark: placemarks[0])
                    let mapItem = MKMapItem(placemark: placeMark)
                    mapItem.name = self.requestEmail
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: options)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: requestLocation, span: span)
        map.setRegion(region, animated: false)
        
        let anotation = MKPointAnnotation()
        anotation.title = requestEmail
        anotation.coordinate = requestLocation
        map.addAnnotation(anotation)
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
