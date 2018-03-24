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
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: "http://localhost:5001/users") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            let json = JSON(data)
            
            guard let address = json["transactions"].array?[0]["recipient"].string else {
                return
            }
            
            SigmaUserDefaults.set(address, forKey: .userIdentifier)
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "userSegue", sender: self)
            }
        }
        
        task.resume()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        performSegue(withIdentifier: "shelterSegue", sender: self)
    }
}
