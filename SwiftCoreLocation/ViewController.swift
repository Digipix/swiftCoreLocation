//
//  ViewController.swift
//  SwiftCoreLocation
//  Created by Eric Gu on 10/5/14.
//  Copyright (c) 2014 Eric Gu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()

    @IBOutlet weak var theMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager.requestWhenInUseAuthorization()
    }

//MARK: location manager
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let latitude:CLLocationDegrees = locValue.latitude
        let longitude: CLLocationDegrees = locValue.longitude
        
        //change for Zoom Level
        let latDelta: CLLocationDegrees = 0.5
        let longDelta: CLLocationDegrees = 0.5
        
        //update the map
        var theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        self.theMap.setRegion(theRegion, animated: true)
        
        //stop updating location for manual update
        self.manager.stopUpdatingLocation()

    }
    
    @IBAction func updateMap(sender: AnyObject) {
        
        if (CLLocationManager.locationServicesEnabled())
        {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }
    
}

