//
//  ShelterInfoCell.swift
//  Sigma
//
//  Created by Annie on 3/25/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class ShelterInfoCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configure(shelter: Shelter) {
        nameLabel.text = shelter.name
        addressLabel.text = shelter.address
    }
}

