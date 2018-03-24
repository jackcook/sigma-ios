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
    var body: Parameters { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    func handleRequest(_ json: JSON?, _ completion: @escaping (Value?) -> Void)
}

extension SigmaRequest {
    
    private var baseURL: String {
        return "http://sigma.us-east-1.elasticbeanstalk.com"
    }
    
    func start(completion: @escaping (Value?) -> Void) {
        Alamofire.request("\(baseURL)\(endpoint)", method: method, parameters: body, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            guard let data = response.result.value else {
                completion(nil)
                return
            }
            
            let json = JSON(data)
            
            DispatchQueue.main.async {
                self.handleRequest(json, completion)
            }
        }
    }
}
