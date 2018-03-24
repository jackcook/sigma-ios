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

protocol MapViewDelegate {
    func shouldDisplayInformation(for shelter: Shelter)
}

class MapView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: MapViewDelegate?
    
    private var locationManager: CLLocationManager!
    private var shelters = [Shelter]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapView.delegate = self
        
        SheltersRequest().start { shelters in
            guard let shelters = shelters else {
                return
            }
            
            self.shelters = shelters
            
            for shelter in shelters {
                let pin = MKPointAnnotation()
                
                pin.coordinate = CLLocationCoordinate2DMake(shelter.latitude, shelter.longitude)
                pin.title = shelter.address
                
                self.mapView.addAnnotation(pin)
            }
        }
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
//            locationManager.desiredAccuracy = CLLocationAccuracy
            locationManager.startUpdatingLocation()
        } else{
            return
        }
    }
    
    func configure(shelters: [Shelter]) {
        self.shelters = shelters
    }
    
    // MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    // MARK: MKMapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let viewAnnotation = view.annotation else {
            return
        }
        
        var index = 0
        
        for (idx, annotation) in mapView.annotations.enumerated() {
            if annotation.coordinate.latitude == viewAnnotation.coordinate.latitude && annotation.coordinate.longitude == viewAnnotation.coordinate.longitude {
                index = idx
                break
            }
        }
        
        let shelter = shelters[0]
        delegate?.shouldDisplayInformation(for: shelter)
    }
}
