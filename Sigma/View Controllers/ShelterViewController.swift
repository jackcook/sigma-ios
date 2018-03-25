//
//  ShelterViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import EFQRCode
import UIKit

struct Consumable {
    var name: String
    var cost: Int
}

struct Task {
    var name: String
    var value: Int
}

class ShelterViewController: UIViewController, SigmaTabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var bottomBar: SigmaTabBar!
    
    private var selectedTab = 0
    
    private var consumableToSend: Consumable?
    private var taskToSend: Task?
    private var userToDisplay: User?
    
    private let consumables = [
        Consumable(name: "1 meal", cost: 5),
        Consumable(name: "½ gallon of water", cost: 5),
        Consumable(name: "1 gallon of gas", cost: 10),
        Consumable(name: "10 minute shower", cost: 3),
        Consumable(name: "Blanket", cost: 5)
    ]
    
    private let tasks = [
        Task(name: "Check in", value: 10),
        Task(name: "Clear debris from the road", value: 10),
        Task(name: "Recycle 5 bottles", value: 1),
        Task(name: "Help distribute goods", value: 3),
        Task(name: "Clean the shelter", value: 3),
        Task(name: "Help find trapped people", value: 10),
        Task(name: "Help rebuild houses", value: 10),
        Task(name: "Babysit children in the shelter", value: 5),
        Task(name: "Cook meals for the shelter", value: 5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.delegate = self
        
        let tabs = [
            SigmaTab(name: "Items", image: #imageLiteral(resourceName: "Water")),
            SigmaTab(name: "Tasks", image: #imageLiteral(resourceName: "Clipboard"))
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
        case "transactionSegue":
            guard let transactionController = segue.destination as? TransactionViewController else {
                return
            }
            
            if selectedTab == 0 {
                transactionController.consumable = consumableToSend
            } else {
                transactionController.task = taskToSend
            }
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
        selectedTab = index
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

        if selectedTab == 0 {
            cell.configure(name: consumables[indexPath.row].name, cost: consumables[indexPath.row].cost)
        } else {
            cell.configure(name: tasks[indexPath.row].name, cost: tasks[indexPath.row].value)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTab == 0 ? consumables.count : tasks.count
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedTab == 0 {
            consumableToSend = consumables[indexPath.row]
        } else {
            taskToSend = tasks[indexPath.row]
        }
        
        performSegue(withIdentifier: "transactionSegue", sender: self)
    }
}
