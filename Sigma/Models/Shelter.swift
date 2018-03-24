//
//  Shelter.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import SwiftyJSON

struct Shelter {
    
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let data: [String: JSON]
    
    init(json: JSON) {
        id = json["shelter_id"].string ?? ""
        name = json["name"].string ?? ""
        address = json["address"].string ?? ""
        latitude = json["lat"].double ?? 0
        longitude = json["lng"].double ?? 0
        data = json["data"].dictionary ?? [String: JSON]()
    }
}
