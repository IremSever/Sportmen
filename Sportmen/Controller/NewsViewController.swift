//
//  NewsController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    let newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        loadNewsData()
    }
    private func loadNewsData() {
        newsViewModel.fetchNewsData { [weak self] in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsViewModel.cellForRowAt(indexPath: indexPath)
        
        if indexPath.row % 4 == 0 {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NewsTableViewCell1
            cell.setCell1WithValuesOf(news)
            print("cell1")
            return cell
        } else {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! NewsTableViewCell2
            cell.setCell2WithValuesOf(news)
            print("cell2")
            return cell
        }
    }
}
