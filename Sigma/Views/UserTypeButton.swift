//
//  UserTypeButton.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

enum UserType {
    case person, shelter, scan, confirm
}

class UserTypeButton: UIButton {
    
    var type: UserType = .person {
        didSet {
            layer.cornerRadius = 4
            
            if type == .person {
                backgroundColor = UIColor.darkGray
                setTitleColor(.white, for: .normal)
            } else if type == .shelter {
                backgroundColor = UIColor.white
                layer.borderColor = UIColor.darkGray.cgColor
                layer.borderWidth = 2
                setTitleColor(.black, for: .normal)
            } else if type == .scan {
                backgroundColor = UIColor.green
                setTitleColor(.white, for: .normal)
            } else if type == .confirm {
                backgroundColor = UIColor.blue
                setTitleColor(.white, for: .normal)
            }
        }
    }
}
