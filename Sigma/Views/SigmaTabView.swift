//
//  SigmaTabView.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class SigmaTabView: UIView {
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    
    var tab: SigmaTab!
    
    init(tab: SigmaTab) {
        super.init(frame: CGRect.zero)
        
        self.tab = tab
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        nameLabel.text = tab.name
//        nameLabel.textColor = UIColor.accentDarkColor()
        nameLabel.textColor = UIColor.black
        
        imageView = UIImageView(image: tab.image)
        imageView.image = tab.image.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = UIColor.accentDarkColor()
        imageView.tintColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if nameLabel.superview == nil {
            addSubview(nameLabel)
        }
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: (bounds.width - nameLabel.bounds.width) / 2, y: bounds.height - nameLabel.bounds.height - 8, width: nameLabel.bounds.width, height: nameLabel.bounds.height)
        
        let imageWidth = nameLabel.frame.origin.y - 16
        if imageView.superview == nil {
            addSubview(imageView)
        }
        imageView.frame = CGRect(x: (bounds.width - imageWidth) / 2, y: 10, width: imageWidth, height: imageWidth)
    }
}
