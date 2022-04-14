//
//  ViewController.swift
//  where-am-i
//
//  Created by Emerson.Novais on 13/04/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapReference: MKMapView!
    
    var managerLocation = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerLocation.delegate = self
        managerLocation.desiredAccuracy = kCLLocationAccuracyBest
        managerLocation.requestWhenInUseAuthorization()
        managerLocation.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            // configurar alert
        }
        
    }

}

