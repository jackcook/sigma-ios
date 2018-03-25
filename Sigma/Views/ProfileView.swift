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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var user: User!
    
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
        return user.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TransactionCell")
        cell.textLabel?.text = "Jack sent 10σ to Annie"
        cell.detailTextLabel?.text = "March 29, 2018"
        return cell
    }
}
