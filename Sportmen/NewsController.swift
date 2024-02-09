//
//  NewsController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import Foundation
import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text =  "Title"
        content.secondaryText = "Details"
        cell.contentConfiguration = content
        return cell
    }
}
