//
//  SheltersRequest.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class SheltersRequest: SigmaRequest {
    
    typealias Value = [Shelter]
    
    var endpoint: String {
        return "/shelters"
    }
    
    func handleRequest(_ json: JSON?, _ completion: @escaping ([Shelter]?) -> Void) {
        guard let sheltersData = json?.array else {
            completion(nil)
            return
        }
        
        var shelters = [Shelter]()
        
        for shelterDatum in sheltersData {
            let shelter = Shelter(json: shelterDatum)
            shelters.append(shelter)
        }
        
        completion(shelters)
    }
}