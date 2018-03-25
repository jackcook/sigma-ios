//
//  UserViewController.swift
//  Sigma
//
//  Created by Annie on 3/23/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, MapViewDelegate, ProfileViewDelegate, SigmaTabBarDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomBar: SigmaTabBar!
    
    var user: User!
    
    private var mapView: MapView?
    private var profileView: ProfileView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.delegate = self
        
        let tabs = [
            SigmaTab(name: "News", image: #imageLiteral(resourceName: "Feed")),
            SigmaTab(name: "Map", image: #imageLiteral(resourceName: "Globe")),
            SigmaTab(name: "Profile", image: #imageLiteral(resourceName: "User"))
        ]
        
        bottomBar.updateTabs(tabs)
        needsProfileUpdate { user in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let profileView = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? ProfileView else {
            return
        }
        
        contentView.addSubview(profileView)
        profileView.delegate = self
        profileView.frame = contentView.bounds
        profileView.user = user
        self.profileView = profileView
        
        guard let mapView = Bundle.main.loadNibNamed("MapView", owner: self, options: nil)?.first as? MapView else {
            return
        }
        
        contentView.addSubview(mapView)
        mapView.delegate = self
        mapView.frame = contentView.bounds
        self.mapView = mapView
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
    
    // MARK: MapViewDelegate Methods
    
    func shouldDisplayInformation(for shelter: Shelter) {
        performSegue(withIdentifier: "placeSegue", sender: self)
    }
    
    // MARK: ProfileViewDelegate Methods
    
    func needsProfileUpdate(completion: @escaping (User?) -> Void) {
        guard let userIdentifier = SigmaUserDefaults.string(forKey: .userIdentifier) else {
            return
        }
        
        UserRequest(id: userIdentifier).start { user in
            guard let user = user else {
                return
            }
            
            self.user = user
            self.profileView?.user = user
            
            completion(user)
        }
    }
    
    // MARK: SigmaTabBarDelegate Methods
    
    func updatedSelectedTab(_ index: Int) {
        guard let mapView = mapView, let profileView = profileView else {
            return
        }
        
        mapView.isUserInteractionEnabled = false
        profileView.isUserInteractionEnabled = false
        
        switch index {
        case 1:
            mapView.isUserInteractionEnabled = true
            contentView.bringSubview(toFront: mapView)
        case 2:
            profileView.isUserInteractionEnabled = true
            contentView.bringSubview(toFront: profileView)
        default:
            break
        }
    }
}
