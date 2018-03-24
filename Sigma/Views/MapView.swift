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
        
        let session = URLSession(configuration: .default)
        
        let url = URL(string: "http://sigma.us-east-1.elasticbeanstalk.com/shelters")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            let json = JSON(data)
            
            guard let shelters = json.array else {
                return
            }
            
            for shelter in shelters {
                guard let lat = shelter["lat"].double, let lng = shelter["lng"].double else {
                    break
                }
                
                let pin = MKPointAnnotation()
                
                let location = CLLocationCoordinate2DMake(lat, lng)
                pin.coordinate = location
                
                self.mapView.addAnnotation(pin)
            }
        }
        
        task.resume()
    }
}
