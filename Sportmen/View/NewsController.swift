//
//  NewsController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import Foundation
import UIKit
import Combine

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    let newsVM = NewsViewModel()
    var cancellables = Set<AnyCancellable>()
    
    var newsList: [Datum] = [] {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        setupBindings()
        newsVM.requestData()
    }
    
    private func setupBindings() {
        // Error Message
        newsVM.error
            .receive(on: DispatchQueue.main)
            .sink { errorString in
                print(errorString)
            }
            .store(in: &cancellables)
        
        newsVM.news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] news in
                self?.newsList = news.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = newsList[indexPath.row].image ?? ""
        content.secondaryText = newsList[indexPath.row].title ?? ""
        content.secondaryText = newsList[indexPath.row].spot ?? ""
        cell.contentConfiguration = content
        
        return cell
    }
}

