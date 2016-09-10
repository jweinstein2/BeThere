//
//  LocationUtil.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationUtil: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationUtil()
    
    var backgroundFunction : (() -> ()) = {}
    var locationManager = CLLocationManager()
    
    func setup() {
        handleLocationPermissions()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        if Float(UIDevice.currentDevice().systemVersion) >= 9 {
            locationManager.allowsBackgroundLocationUpdates = true
        }
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
            locationManager.requestLocation()
            // ...
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("did update locations")
        if UIApplication.sharedApplication().applicationState == .Background {
            //Location updated in background make a server call
            backgroundFunction()
            NSLog("SERVER CALL")
        } else {
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("did fail with error")
        NSLog(String(error))
    }
    
    func uploadNextLocation(completionHandler: () -> ()){
        
    }
}