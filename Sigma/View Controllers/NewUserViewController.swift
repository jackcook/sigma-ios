//
//  NewUserViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var userToSend: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "homeSegue":
            guard let userController = segue.destination as? UserViewController, let user = userToSend else {
                return
            }
            
            userController.user = user
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        CreateUserRequest(name: text).start { user in
            guard let user = user else {
                return
            }
            
            SigmaUserDefaults.set(user.id, forKey: .userIdentifier)
            self.userToSend = user
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
        
        return true
    }
}
