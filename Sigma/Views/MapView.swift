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

class MapView: UIView {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SheltersRequest().start { shelters in
            guard let shelters = shelters else {
                return
            }
            
            for shelter in shelters {
                let pin = MKPointAnnotation()
                
                let location = CLLocationCoordinate2DMake(shelter.latitude, shelter.longitude)
                pin.coordinate = location
                
                self.mapView.addAnnotation(pin)
            }
        }
    }
}
