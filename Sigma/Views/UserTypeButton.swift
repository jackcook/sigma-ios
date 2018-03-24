//
//  UserTypeButton.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

enum UserType {
    case person, shelter
}

class UserTypeButton: UIButton {
    
    var type: UserType = .person {
        didSet {
            layer.cornerRadius = 4
            
            if type == .person {
                backgroundColor = UIColor.black
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = UIColor.white
                layer.borderColor = UIColor.black.cgColor
                layer.borderWidth = 2
                setTitleColor(.black, for: .normal)
            }
        }
    }
}
