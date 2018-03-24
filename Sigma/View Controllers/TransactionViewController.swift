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
    @IBOutlet weak var scanButton: UserTypeButton!
    @IBOutlet weak var userIdentifierLabel: UILabel!
    @IBOutlet weak var confirmButton: UserTypeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanButton.type = .scan
        confirmButton.type = .confirm
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
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        guard let cgImage = image.cgImage, let tryCodes = EFQRCode.recognize(image: cgImage) else {
            return
        }
        
        for (index, code) in tryCodes.enumerated() {
            print("The content of \(index) QR Code is: \(code)")
            userIdentifierLabel.text = code
        }
    }
}
