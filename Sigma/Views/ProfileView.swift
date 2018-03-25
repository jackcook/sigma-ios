//
//  ProfileView.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

protocol ProfileViewDelegate {
    func needsProfileUpdate(completion: @escaping (User?) -> Void)
}

class ProfileView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var delegate: ProfileViewDelegate?
    
    var user: User? {
        didSet {
            transactionsTableView.reloadData()
        }
    }
    
    private var refreshControl = UIRefreshControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        transactionsTableView.dataSource = self
        
        let nib = UINib(nibName: "ProfileInfoCell", bundle: nil)
        transactionsTableView.register(nib, forCellReuseIdentifier: "ProfileInfoCell")
        
        refreshControl.addTarget(self, action: #selector(refreshProfileData), for: .valueChanged)
        transactionsTableView.addSubview(refreshControl)
    }
    
    @objc private func refreshProfileData() {
        delegate?.needsProfileUpdate { user in
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.transactions.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = user else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath) as? ProfileInfoCell else {
                return UITableViewCell()
            }
            
            cell.configure(user: user)
            return cell
        default:
            let transaction = user.transactions.reversed()[indexPath.row - 1]
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
}
