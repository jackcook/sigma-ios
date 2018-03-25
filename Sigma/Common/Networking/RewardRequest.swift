//
//  RewardRequest.swift
//  Sigma
//
//  Created by Jack Cook on 3/25/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class RewardRequest: SigmaRequest {
    
    typealias Value = Transaction
    
    var body: Parameters? {
        return [
            "recipient": recipient,
            "amount": amount
        ]
    }
    
    var endpoint: String {
        return "/transactions/reward"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    private let recipient: String
    private let amount: Int
    
    init(recipient: String, amount: Int) {
        self.recipient = recipient
        self.amount = amount
    }
    
    func handleRequest(_ json: JSON?, _ completion: @escaping (Transaction?) -> Void) {
        guard let transactionData = json?["transactions"][0] else {
            completion(nil)
            return
        }
        
        let transaction = Transaction(json: transactionData)
        completion(transaction)
    }
}

