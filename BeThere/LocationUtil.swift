//
//  LocationUtil.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtil: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationUtil()
    
    var locationManager = CLLocationManager()
    
    func setup() {
        handleLocationPermissions()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    private func handleLocationPermissions(){
        //TODO: Handle the different cases resulting from this
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            // ...
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locations")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
}