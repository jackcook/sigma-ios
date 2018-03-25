//
//  TransactionViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

class TransactionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var scanButton: UserTypeButton!
    @IBOutlet weak var userIdentifierLabel: UILabel!
    @IBOutlet weak var confirmButton: UserTypeButton!
    
    var consumable: Consumable?
    var task: Task?
    
    private var senderIdentifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanButton.type = .scan
        confirmButton.type = .confirm
        
        userIdentifierLabel.alpha = 0
        confirmButton.alpha = 0
        
        if let consumable = consumable {
            nameLabel.text = consumable.name
            amountLabel.text = "\(consumable.cost) Sigma Coins"
        } else if let task = task {
            nameLabel.text = task.name
            amountLabel.text = "\(task.value) Sigma Coins"
        }
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
    
    @IBAction func scanButton(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = false
        pickerController.delegate = self
        pickerController.sourceType = .camera
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        guard let id = senderIdentifier else {
            return
        }
        
        if let consumable = consumable {
            PaymentRequest(sender: id, amount: consumable.cost).start { transaction in
                self.navigationController?.popViewController(animated: true)
            }
        } else if let task = task {
            RewardRequest(recipient: id, amount: task.value).start { transaction in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        guard let cgImage = image.cgImage, let senderId = EFQRCode.recognize(image: cgImage)?.first else {
            return
        }
        
        senderIdentifier = senderId
        
        UserRequest(id: senderId).start { user in
            guard let user = user else {
                return
            }
            
            if let _ = self.consumable {
                self.userIdentifierLabel.text = "From: \(user.name)"
            } else {
                self.userIdentifierLabel.text = "Recipient: \(user.name)"
            }
            
            UIView.animate(withDuration: 0.25) {
                self.userIdentifierLabel.alpha = 1
                self.confirmButton.alpha = 1
            }
        }
    }
}
