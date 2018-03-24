//
//  ProfileView.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let tryImage = EFQRCode.generate(content: "a") {
            imageView.image = UIImage(cgImage: tryImage)
        }
    }
}
