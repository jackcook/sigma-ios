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
    let balance: Int
    let transactions: [Transaction]
    
    init(json: JSON) {
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
        
        id = transactions.first?.recipient ?? ""
        
        var balance = 0
        
        for transaction in transactions {
            if transaction.recipient == id {
                balance += transaction.amount
            } else if transaction.sender == id {
                balance -= transaction.amount
            }
        }
        
        self.balance = balance
    }
}
