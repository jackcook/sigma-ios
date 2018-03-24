//
//  CreateUserRequest.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class CreateUserRequest: SigmaRequest {
    
    typealias Value = User
    
    var endpoint: String {
        return "/users"
    }
    
    func handleRequest(_ json: JSON?, _ completion: @escaping (User?) -> Void) {
        guard let userData = json else {
            completion(nil)
            return
        }
        
        let user = User(json: userData)
        completion(user)
    }
}
