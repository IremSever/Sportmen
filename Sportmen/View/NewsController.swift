//
//  NewsController.swift
//  Sportmen
//
//  Created by IREM SEVER on 8.02.2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    let newsVM = NewsViewModel()
    let disposeBag = DisposeBag()
    
    var newsList : [Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        setupBindings()
        newsVM.requestData()
    }
    
    private func setupBindings(){
        // Error Message
        newsVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        newsVM
            .news
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                self.newsList = news.data ?? []
                self.newsTableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text =  newsList[indexPath.row].image ?? ""
        content.secondaryText = newsList[indexPath.row].title ?? ""
        content.secondaryText = newsList[indexPath.row].spot ?? ""
        cell.contentConfiguration = content
        return cell
    }
}
