//
//  NewsController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import Foundation
import UIKit
import Combine

class NewsController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    let newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewsData()
    }
    
    private func loadNewsData() {
        newsViewModel.fetchNewsData { [weak self] in
            self?.newsTableView.dataSource = self
            self?.newsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource Extension
extension NewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsViewModel.cellForRowAt(indexPath: indexPath)
        
        if indexPath.row == 0 {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NewsTableViewCell
            cell.setCell1WithValuesOf(news)
            return cell
        } else {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! NewsTableViewCell
            cell.setCell2WithValuesOf(news)
            return cell
        }
    }
}
