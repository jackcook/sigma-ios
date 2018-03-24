//
//  SigmaTabBar.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class SigmaTabBar: UIView {
    
    var delegate: SigmaTabBarDelegate?
    var selectedTab = 0
    
    private var tabViews = [SigmaTabView]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tabWidth = bounds.width / CGFloat(tabViews.count)
        
        var x: CGFloat = 0
        for tab in tabViews {
            tab.frame = CGRect(x: x, y: 0, width: tabWidth, height: bounds.height)
            x += tabWidth
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.location(in: self)
        
        for (idx, tab) in tabViews.enumerated() where tab.frame.contains(point) {
            selectTab(idx)
            break
        }
    }
    
    func selectTab(_ idx: Int) {
        for tab in tabViews {
            tab.imageView.tintColor = UIColor.darkGray
            tab.nameLabel.textColor = UIColor.darkGray
//            tab.imageView.tintColor = UIColor.accentGrayColor()
//            tab.nameLabel.textColor = UIColor.accentGrayColor()
        }
        
        tabViews[idx].imageView.tintColor = UIColor.black
        tabViews[idx].nameLabel.textColor = UIColor.black
//        tabViews[idx].imageView.tintColor = UIColor.accentDarkColor()
//        tabViews[idx].nameLabel.textColor = UIColor.accentDarkColor()
        
        selectedTab = idx
        delegate?.updatedSelectedTab(idx)
    }
    
    func updateTabs(_ tabs: [SigmaTab]) {
        for tabView in tabViews {
            tabView.removeFromSuperview()
        }
        
        for tab in tabs {
            let tabView = SigmaTabView(tab: tab)
            
            addSubview(tabView)
            tabViews.append(tabView)
        }
        
        selectTab(0)
    }
}

protocol SigmaTabBarDelegate {
    func updatedSelectedTab(_ index: Int)
}

struct SigmaTab {
    let name: String
    let image: UIImage
}
