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
        newsViewModel.fetchNewsData{ [weak self] in
            self?.newsTableView.dataSource = self
            self?.newsTableView.reloadData()
        }
    }
    
}

extension NewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NewsTableViewCell
        let news = newsViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(news)
        
        return cell
    }
    
}
