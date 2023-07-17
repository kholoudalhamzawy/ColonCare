//
//  MapViewController.swift
//  colonCancer
//
//  Created by KH on 05/07/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
     
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Permission granted, start location updates
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Permission denied or restricted, handle accordingly
            // You can display an alert or show alternative content
            break
        default:
            // Other cases (e.g., not determined), handle accordingly
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Use the user's location
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            // Update the map's region to center around the user's location
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location retrieval errors
        if let error = error as? CLError {
            switch error.code {
            case .locationUnknown:
                // The location manager was unable to obtain a location right now
                // You can display an alert or update the UI to inform the user
                print("Location unknown")
            case .denied:
                // The user denied access to location services
                // You can display an alert or show alternative content
                print("Location access denied")
            case .network:
                // There was a network-related error in retrieving the location
                // You can display an alert or show alternative content
                print("Network error")
            case .headingFailure:
                // The location manager was unable to retrieve the heading information
                // You can display an alert or update the UI to inform the user
                print("Heading failure")
            default:
                // Other CLError cases, handle accordingly
                break
            }
        } else {
            // Handle other types of errors, if applicable
        }
    }
}
