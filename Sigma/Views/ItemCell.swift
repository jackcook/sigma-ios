//
//  ItemCell.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var followButton: UIButton!
    
    func configure(name: String, cost: Int) {
        nameLabel.text = name
        costLabel.text = "\(cost)σ"
    }
}
