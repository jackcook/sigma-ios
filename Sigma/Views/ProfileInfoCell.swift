//
//  ProfileInfoCell.swift
//  Sigma
//
//  Created by Jack Cook on 3/25/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

class ProfileInfoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var codeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let address = SigmaUserDefaults.string(forKey: .userIdentifier) else {
            return
        }
        
        if let image = EFQRCode.generate(content: address) {
            codeImageView.image = UIImage(cgImage: image)
        }
    }
    
    func configure(user: User) {
        nameLabel.text = user.name
        balanceLabel.text = "Balance: \(user.balance)σ"
    }
}
