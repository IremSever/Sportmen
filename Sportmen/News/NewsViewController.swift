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
    var isModifiedList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        loadNewsData()
        navigationBarDesign()
        
    }
    private func loadNewsData() {
        newsViewModel.fetchNewsData { [weak self] in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
            }
        }
    }
    func showNewsDetail(_ news: Datum) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newsDetailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailVC") as? NewsDetailVC {
            newsDetailVC.selectedNews = news
            navigationController?.pushViewController(newsDetailVC, animated: true)
        }
    }
    
    func navigationBarDesign() {
        let imgAppIcon = UIImageView(image: UIImage(named: "icon_mainmenu"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgAppIcon)
        
        let buttonModifyList = UIButton(type: .custom)
        buttonModifyList.setImage(UIImage(named: "modifylist"), for: .normal)
        buttonModifyList.contentMode = .scaleAspectFit
        buttonModifyList.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonModifyList.addTarget(self, action: #selector(buttonModifyListTapped), for: .touchUpInside)
        let modifyListBarButton = UIBarButtonItem(customView: buttonModifyList)
        
        let buttonMomentNews = UIButton(type: .custom)
        buttonMomentNews.setImage(UIImage(named: "momentnews"), for: .normal)
        buttonMomentNews.contentMode = .scaleAspectFit
        buttonMomentNews.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonMomentNews.addTarget(self, action: #selector(buttonMomentNewsTapped), for: .touchUpInside)
        let momentNewsBarButton = UIBarButtonItem(customView: buttonMomentNews)
        
        navigationItem.rightBarButtonItems = [modifyListBarButton, momentNewsBarButton]
        
        newsTableView.reloadData()
    }
    
    @objc func buttonModifyListTapped() {
        isModifiedList = !isModifiedList
        newsTableView.reloadData()
    }
    @objc func buttonMomentNewsTapped() {
        if let appStoreURL = URL(string: "https://apps.apple.com/tr/app/moment-haber/id1572296166") {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isModifiedList {
            return 122
        }
        if indexPath.row % 4 == 0 {
            return 290
        } else {
            let screenHeight = UIScreen.main.bounds.height
            let remainingHeight = screenHeight - 310
            let cell2Height = remainingHeight / 4
            return cell2Height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsViewModel.cellForRowAt(indexPath: indexPath)
        
        if !isModifiedList {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! NewsTableViewCell2
            cell.setCell2WithValuesOf(news)
            return cell
        } else {
            if indexPath.row % 4 == 0 {
                let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NewsTableViewCell1
                cell.setCell1WithValuesOf(news)
                return cell
            } else {
                let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! NewsTableViewCell2
                cell.setCell2WithValuesOf(news)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = newsViewModel.cellForRowAt(indexPath: indexPath)
        showNewsDetail(selectedNews)
    }
}
