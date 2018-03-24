//
//  MapView.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import MapKit
import SwiftyJSON
import UIKit
import CoreLocation

class MapView: UIView, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
//            locationManager.desiredAccuracy = CLLocationAccuracy
            locationManager.startUpdatingLocation()
        } else{
            return
        }
    
        
        func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
            let location = locations[0]
            let center = location.coordinate
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake(center, span)
            
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }
        
        SheltersRequest().start { shelters in
            guard let shelters = shelters else {
                return
            }
            
            for shelter in shelters {
                let pin = MKPointAnnotation()
                let location = CLLocationCoordinate2DMake(shelter.latitude, shelter.longitude)
                pin.title = shelter.address
                pin.coordinate = location
                
                self.mapView.addAnnotation(pin)
            }
            
        }
    }
}
