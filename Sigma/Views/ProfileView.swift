//
//  ProfileView.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

class ProfileView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            balanceLabel.text = "Balance: \(user?.balance ?? 0)σ"
            transactionsTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let address = SigmaUserDefaults.string(forKey: .userIdentifier) else {
            return
        }
        
        if let tryImage = EFQRCode.generate(content: address) {
            imageView.image = UIImage(cgImage: tryImage)
        }
        
        transactionsTableView.dataSource = self
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transaction = user?.transactions[indexPath.row], let user = user else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TransactionCell")
        
        if transaction.sender == user.id {
            cell.textLabel?.text = "You spent \(transaction.amount)σ"
        } else {
            cell.textLabel?.text = "You received \(transaction.amount)σ"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        cell.detailTextLabel?.text = formatter.string(from: transaction.timestamp)
        
        return cell
    }
}
