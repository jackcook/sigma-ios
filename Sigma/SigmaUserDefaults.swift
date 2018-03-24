//
//  SigmaUserDefaults.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import Foundation

class SigmaUserDefaults: UserDefaults {
    
    static func setDefaultValues() {
        // App settings
        set(true, forKey: .defaultsConfigured)
        
        // User settings
        set(true, forKey: .sendAnonymousUsageData)
    }
    
    static func bool(forKey defaultName: SigmaUserDefaultsKey) -> Bool {
        return standard.bool(forKey: defaultName.rawValue)
    }
    
    static func integer(forKey defaultName: SigmaUserDefaultsKey) -> Int {
        return standard.integer(forKey: defaultName.rawValue)
    }
    
    static func string(forKey defaultName: SigmaUserDefaultsKey) -> String? {
        return standard.string(forKey: defaultName.rawValue)
    }
    
    static func removeObject(forKey defaultName: SigmaUserDefaultsKey) {
        standard.removeObject(forKey: defaultName.rawValue)
    }
    
    static func set(_ value: Bool, forKey defaultName: SigmaUserDefaultsKey) {
        standard.set(value, forKey: defaultName.rawValue)
    }
    
    static func set(_ value: Int, forKey defaultName: SigmaUserDefaultsKey) {
        standard.set(value, forKey: defaultName.rawValue)
    }
    
    static func set(_ value: String, forKey defaultName: SigmaUserDefaultsKey) {
        standard.set(value, forKey: defaultName.rawValue)
    }
}
