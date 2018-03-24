//
//  Transaction.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import SwiftyJSON

struct Transaction {
    
    let sender: String
    let recipient: String
    let amount: Int
    
    init(json: JSON) {
        sender = json["sender"].string ?? ""
        recipient = json["recipient"].string ?? ""
        amount = json["amount"].int ?? 0
    }
}
