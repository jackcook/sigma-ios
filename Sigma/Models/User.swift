//
//  User.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import SwiftyJSON

struct User {
    
    let id: String
    let name: String
    let balance: Int
    let transactions: [Transaction]
    
    init(json: JSON) {
        id = json["user_id"].string ?? ""
        name = json["name"].string ?? ""
        balance = json["balance"].int ?? 0
        
        if let transactionsData = json["transactions"].array {
            var transactions = [Transaction]()
            
            for transactionDatum in transactionsData {
                let transaction = Transaction(json: transactionDatum)
                transactions.append(transaction)
            }
            
            self.transactions = transactions
        } else {
            self.transactions = [Transaction]()
        }
    }
}
