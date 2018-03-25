//
//  ShelterViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

class ShelterViewController: UIViewController, SigmaTabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var bottomBar: SigmaTabBar!
    
    private var userToDisplay: User?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "personSegue":
            guard let profileController = segue.destination as? PersonViewController, let user = userToDisplay else {
                return
            }
            
            profileController.user = user
        default:
            break
        }
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = false
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: Sigma Tab Bar Delegate
    
    func updatedSelectedTab(_ index: Int) {
        contentTableView.reloadData()
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
        
        UserRequest(id: senderId).start { user in
            guard let user = user else {
                return
            }
            
            self.userToDisplay = user
            self.performSegue(withIdentifier: "personSegue", sender: self)
        }
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
