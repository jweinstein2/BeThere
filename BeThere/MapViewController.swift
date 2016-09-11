//
//  mapView.swift
//  West Campus
//
//  Created by jared weinstein on 11/13/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var initialLocation : CLLocationCoordinate2D?
    var shouldDisplayUsersLocation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMap()
    }
    
    func setUpMap(){
        map.mapType = MKMapType.Hybrid
        map.showsPointsOfInterest = false

        map.zoomEnabled = true
        map.scrollEnabled = true
        map.showsUserLocation = shouldDisplayUsersLocation
        map.setCenterCoordinate(LocationUtil.sharedInstance.lastLocation?.coordinate ?? CLLocation(latitude: 0,longitude: 0).coordinate, animated: true)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocationCoordinate2D) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(LocationUtil.sharedInstance.lastLocation?.coordinate ?? CLLocation(latitude: 0,longitude: 0).coordinate)
    }
}
