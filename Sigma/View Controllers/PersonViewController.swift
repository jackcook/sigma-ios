//
//  PersonViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, ProfileViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var user: User!
    
    private var profileView: ProfileView?
    
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topShadowPath = UIBezierPath(rect: topBar.bounds)
        topBar.layer.masksToBounds = false
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        topBar.layer.shadowOpacity = 0.15
        topBar.layer.shadowPath = topShadowPath.cgPath
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: ProfileViewDelegate Methods
    
    func needsProfileUpdate(completion: @escaping (User?) -> Void) {
        UserRequest(id: user.id).start { user in
            guard let user = user else {
                return
            }
            
            self.user = user
            self.profileView?.user = user
            
            completion(user)
        }
    }
}
