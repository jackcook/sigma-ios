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
        
        guard let address = SigmaUserDefaults.string(forKey: .userIdentifier) else {
            return
        }
        
        if let tryImage = EFQRCode.generate(content: address) {
            imageView.image = UIImage(cgImage: tryImage)
        }
    }
}
