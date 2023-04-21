//
//  LocationManager.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 06.04.2023.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didLocationUpdate(lon: String, lat: String)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
       // locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let lon = "\(location.coordinate.longitude)"
        let lat = "\(location.coordinate.latitude)"
        delegate?.didLocationUpdate(lon: lon , lat: lat)
        //locationManager.stopUpdatingLocation()
    }
}
