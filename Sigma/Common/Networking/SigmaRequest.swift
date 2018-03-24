//
//  SigmaRequest.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol SigmaRequest {
    associatedtype Value
    var endpoint: String { get }
    func handleRequest(_ json: JSON?, _ completion: @escaping (Value?) -> Void)
}

extension SigmaRequest {
    
    private var baseURL: String {
        return "http://sigma.us-east-1.elasticbeanstalk.com"
    }
    
    func start(completion: @escaping (Value?) -> Void) {
        Alamofire.request("\(baseURL)\(endpoint)").responseJSON { response in
            guard let data = response.result.value else {
                return
            }
            
            let json = JSON(data)
            
            DispatchQueue.main.async {
                self.handleRequest(json, completion)
            }
        }
    }
}
