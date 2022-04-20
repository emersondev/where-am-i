//
//  ViewController.swift
//  where-am-i
//
//  Created by Emerson.Novais on 13/04/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var mapReference: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let deltaLatitude: CLLocationDegrees = 0.001
    let deltaLongitude: CLLocationDegrees = 0.001
    var managerLocation = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerLocation.delegate = self
        managerLocation.desiredAccuracy = kCLLocationAccuracyBest
        managerLocation.requestWhenInUseAuthorization()
        managerLocation.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last!
        let latitude = String(userLocation.coordinate.latitude)
        let longitude = String(userLocation.coordinate.longitude)
        let speed = String(userLocation.speed)
        
        
        speedLabel.textColor = UIColor.black
        latitudeLabel.textColor = UIColor.black
        longitudeLabel.textColor = UIColor.black
        
        latitudeLabel.text = latitude
        longitudeLabel.text = longitude
        
        if (userLocation.speed > 0) {
            speedLabel.text = speed
        }
        
        let areaVisualization: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        
        let localRegion: MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: areaVisualization)
        
        mapReference.setRegion(localRegion, animated: true)
        CLGeocoder().reverseGeocodeLocation(userLocation) { (localDetails, error) in
            
            if error == nil {
                
                if let dataLocal = localDetails?.first {
                    var thoroughfare = ""
                    if dataLocal.thoroughfare != nil {
                        thoroughfare = dataLocal.thoroughfare!
                    }
                    
                    var subThoroughfare = ""
                    if dataLocal.subThoroughfare != nil {
                        subThoroughfare = dataLocal.subThoroughfare!
                    }
                    
                    var locality = ""
                    if dataLocal.locality != nil {
                        locality = dataLocal.locality!
                    }
                    
                    var subLocality = ""
                    if dataLocal.subLocality != nil {
                        subLocality = dataLocal.subLocality!
                    }
                    
                    var postalCode = ""
                    if dataLocal.postalCode != nil {
                        postalCode = dataLocal.postalCode!
                    }
                    
                    var country = ""
                    if dataLocal.country != nil {
                        country = dataLocal.country!
                    }
                    
                    var administrativeArea = ""
                    if dataLocal.administrativeArea != nil {
                        administrativeArea = dataLocal.administrativeArea!
                    }
                    
                    var subAdministrativeArea = ""
                    if dataLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dataLocal.subAdministrativeArea!
                    }
                    
                    self.addressLabel.textColor = UIColor.black
                    self.addressLabel.text = thoroughfare + " - "
                                            + subThoroughfare + " / "
                                            + locality + " / "
                                            + country
                    
                    print(
                            "\n / thoroughfare:" + thoroughfare +
                            "\n / subThoroughfare:" + subThoroughfare +
                            "\n / locality:" + locality +
                            "\n / subLocality:" + subLocality +
                            "\n / postalCode:" + postalCode +
                            "\n / country:" + country +
                            "\n / administrativeArea:" + administrativeArea +
                            "\n / subAdministrativeArea:" + subAdministrativeArea
                    )
                }
            } else {
                print(error)
            }
        }
    }
       
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            let alertController = UIAlertController(
                title: "Permissão de Localização",
                message: "Necessária permissão para acesso à sua localização!! por favor habilite",
                preferredStyle: .alert
            )
            let actionConfig = UIAlertAction(title: "Abrir configurações", style: .default) { (alertConfigurations) in
                if let config = NSURL(string: UIApplicationOpenNotificationSettingsURLString) {
                    UIApplication.shared.open(config as URL)
                }
            }
            let actionCancel = UIAlertAction(
                title: "Cancelar",
                style: .default,
                handler: nil
            )
            alertController.addAction(actionConfig)
            alertController.addAction(actionCancel)
            present(alertController, animated: true, completion: nil)
        }
    }
    
}

