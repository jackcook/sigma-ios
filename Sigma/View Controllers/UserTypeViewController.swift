//
//  UserTypeViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import SwiftyJSON
import UIKit

class UserTypeViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UserTypeButton!
    @IBOutlet weak var registerShelterButton: UserTypeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.type = .person
        registerShelterButton.type = .shelter
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        SigmaUserDefaults.set(false, forKey: .isShelterVolunteer)
        performSegue(withIdentifier: "userSegue", sender: self)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        SigmaUserDefaults.set(true, forKey: .isShelterVolunteer)
        performSegue(withIdentifier: "shelterSegue", sender: self)
    }
}
