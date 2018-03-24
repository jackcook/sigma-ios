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
                backgroundColor = UIColor.black
                setTitleColor(.white, for: .normal)
            } else if type == .shelter {
                backgroundColor = UIColor.white
                layer.borderColor = UIColor.black.cgColor
                layer.borderWidth = 2
                setTitleColor(.black, for: .normal)
            } else if type == .scan {
                backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
                setTitleColor(.white, for: .normal)
            } else if type == .confirm {
                backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
                setTitleColor(.white, for: .normal)
            }
        }
    }
}
