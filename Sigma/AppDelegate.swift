//
//  AppDelegate.swift
//  Sigma
//
//  Created by Annie on 3/23/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Set default values on first app launch
        if !SigmaUserDefaults.bool(forKey: .defaultsConfigured) {
            SigmaUserDefaults.setDefaultValues()
        }
        
        return true
    }
}
