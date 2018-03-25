//
//  UpdatesView.swift
//  Sigma
//
//  Created by Annie on 3/25/18.
//  Copyright © 2018 Sigma. All rights reserved.
//

import UIKit

private struct Section {
    var title: String
    var description: String
}

class UpdatesView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var updatesTableView: UITableView!
    
    private let dataSource = [
        Section(title: "September 12, 2017 7:30 am\nPark Vista Community High School\nPublic High School\n7900 Jog Rd, Lake Worth, FL 33467\n(561) 491-8400", description:"Task: Clear trees from the road (1 hour)\nReward: 10σ"),
        Section(title: "September 12, 2017 7:40 am\nPark Vista Community High School\nPublic High School\n7900 Jog Rd, Lake Worth, FL 33467\n(561) 491-8400", description: "Task: Help find trapped people (1 hour)\nReward: 10σ"),
        Section(title: "September 13, 2017 9:40 am\nPalm Beach Central High School\n8499 Forest Hill Blvd, Wellington, FL 33411\n(561) 304-1000", description: "Task: Babysit children in the shelter (1 hour)\nReward: 5σ"),
        Section(title: "September 14, 2017 7:40 am\nPark Vista Community High School\nPublic High School\n7900 Jog Rd, Lake Worth, FL 33467\n(561) 491-8400", description: "Task: Help rebuild houses (1 hour)\nReward: 10σ")
    ]
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updatesTableView.dataSource = self
        
        let nib = UINib(nibName: "UpdateCell", bundle: nil)
        updatesTableView.register(nib, forCellReuseIdentifier: "UpdateCell")
    }
    
    // MARK: UITableViewUpdatesSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateCell", for: indexPath) as? UpdateCell else {
            return UITableViewCell()
        }
            
        cell.titleLabel.text = dataSource[indexPath.row].title
        cell.descriptionLabel.text = dataSource[indexPath.row].description
            
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0: return 112
//        default:
//            let horizontalMargin: CGFloat = 30
//            let verticalMargin: CGFloat = 51
//
//            let description = dataSource[indexPath.row - 1].description as NSString
//            let boundingSize = CGSize(width: tableView.frame.size.width - horizontalMargin, height: .greatestFiniteMagnitude)
//            let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 14)]
//            let size = description.boundingRect(with: boundingSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil).size
//
//            return size.height + verticalMargin
//        }
//    }    
}
