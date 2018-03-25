//
//  PlaceViewController.swift
//  Sigma
//
//  Created by Jack Cook on 3/24/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

private struct Section {
    var title: String
    var description: String
}

class PlaceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentTableView: UITableView!
    
    private let dataSource = [
        Section(title: "Open Hours", description: "24/7"),
        Section(title: "Meal Plan", description: "Breakfast = 5 σ \n• Granola bars \n•Cereal with milk \n• Peanut butter sandwich \n• Applesauce \nLunch = 5 σ \n• Macaroni and cheese \n• Canned tuna and canned peas \n• Beef stew and bread \n• Canned mandarin orange \n• Canned peach \nDinner = 5 σ \n• Canned chicken with canned corn and carrots \n• Fried rice with spam and canned peas and carrots \n• Spaghetti with ground beef and tomato sauce \n• Canned pears \n• Canned pineapple"),
        Section(title: "Resources", description: "• Water(1/2 gal) = 5 σ \n• Fuel (1 gal) = 10 σ \n• Shower (10 min) = 15 σ \n• Toothbrush = 2 σ \n• Toothpaste = 2 σ \n• Soap = 2 σ \n• Shampoo = 2 σ \n• Towel = 1 σ \n•  Clothing = 2 σ \n•  Sleeping bag = 5 σ"),
        Section(title: "Tasks", description: "Clear trees from the road (1 hour) = 10 σ \n•Help rebuild houses (1 hour) = 10 σ \n•Clearing the trees from the road (1 hour) = 10 σ")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.dataSource = self
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
    
    // MARK: Number of rows in particular section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShelterInfoCell", for: indexPath) as? ItemCell else {
                return UITableViewCell()
            }
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? ShelterDataCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = dataSource[indexPath.row - 1].title
            cell.descriptionView.text = dataSource[indexPath.row - 1].description
            
            return cell
        }
    }
    
   
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "transactionSegue", sender: self)
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
