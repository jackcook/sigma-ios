//
//  ShelterViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class ShelterViewController: UIViewController, SigmaTabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var bottomBar: SigmaTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.delegate = self
        
        let tabs = [
            SigmaTab(name: "Receive", image: #imageLiteral(resourceName: "Globe")),
            SigmaTab(name: "Pay Out", image: #imageLiteral(resourceName: "User"))
        ]
        
        bottomBar.updateTabs(tabs)
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
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
        contentTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: "Recycle", cost: 4)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "transactionSegue", sender: self)
    }
}
