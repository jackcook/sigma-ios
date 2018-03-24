//
//  MainViewController.swift
//  Sigma
//
//  Created by Annie on 3/23/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SigmaTabBarDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomBar: SigmaTabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.delegate = self
        
        let tabs = [
            SigmaTab(name: "News", image: #imageLiteral(resourceName: "Feed")),
            SigmaTab(name: "Map", image: #imageLiteral(resourceName: "Globe")),
            SigmaTab(name: "Profile", image: #imageLiteral(resourceName: "User"))
        ]
        
        bottomBar.updateTabs(tabs)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let profileView = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? ProfileView else {
            return
        }
        
        contentView.addSubview(profileView)
        profileView.frame = contentView.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topShadowPath = UIBezierPath(rect: topBar.bounds)
        topBar.layer.masksToBounds = false
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        topBar.layer.shadowOpacity = 0.15
        topBar.layer.shadowPath = topShadowPath.cgPath
        
        let bottomShadowPath = UIBezierPath(rect: bottomBar.bounds)
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowPath = bottomShadowPath.cgPath
    }
    
    // MARK: Sigma Tab Bar Delegate
    
    func updatedSelectedTab(_ index: Int) {
        print(index)
    }
}
