//
//  PaymentRequest.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class PaymentRequest: SigmaRequest {
    
    typealias Value = Transaction
    
    var body: Parameters? {
        return [
            "sender": sender,
            "amount": amount
        ]
    }
    
    var endpoint: String {
        return "/transactions/purchase"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    private let sender: String
    private let amount: Int
    
    init(sender: String, amount: Int) {
        self.sender = sender
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
