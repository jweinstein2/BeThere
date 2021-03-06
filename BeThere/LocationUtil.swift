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
import Alamofire

class LocationUtil: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationUtil()
    
    var lastLocation : CLLocation?
    
    var backgroundFunction : (() -> ())?
    var id : String?
    
    var locationManager = CLLocationManager()
    
    func setup() {
        handleLocationPermissions()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
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
        if locations.first != nil {
            lastLocation = locations.first
            
            NSLog("update locations")
            if (backgroundFunction != nil) {
                //Location updated in background make a server call
                
                let url = "\(Utilities.getURL())/event/\(id!)/location?latitude=\(lastLocation!.coordinate.latitude)&longitude=\(lastLocation!.coordinate.longitude)"
                NSLog(url)
                Alamofire.request(.POST, url)
                    .responseString() { string in
                        
                        NSLog("RESPONSE : \(string.description)")
                        if string.description.containsString("true") {
                            NSLog("You made it in time")
                        } else if string.description.containsString("false") {
                            NSLog("You didn't make it in time")
                        } else {
                            NSLog("SOMETHING WENT VERY WRONG")
                        }
                }
                
                backgroundFunction!()
                id = nil
                backgroundFunction = nil
                
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("did fail with error")
        NSLog(String(error))
    }
    
    func uploadNextLocation(completionHandler: () -> ()){
        
    }
}