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
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell1")
        newsTableView.register(NewsTableViewCell2.self, forCellReuseIdentifier: "cell2")
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
        let news = newsList[indexPath.row]
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NewsTableViewCell
            cell.configure(with: news)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! NewsTableViewCell2
            cell.configure(with: news)
            return cell
        }
    }
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_cell1: UIImageView?
    
    @IBOutlet weak var source_cell1: UILabel?
    @IBOutlet weak var title_cell1: UILabel?
    
    func configure(with news: Datum) {
        if let imageUrlString = news.image, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.img_cell1?.image = image
                    }
                }
            }.resume()
        }
        
        if let titleCell = title_cell1 {
            titleCell.text = news.title
        }
        
        if let source = news.source {
            source_cell1?.text = source.name.rawValue
        } else {
            source_cell1!.text = "Unknown Source"
        }
        
    }
}

class NewsTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var img_cell2: UIImageView?
    
    @IBOutlet weak var spot_cell2: UILabel?
    
    @IBOutlet weak var publishedDate_cell2: UILabel?
    
    @IBOutlet weak var title_cell2: UILabel?
    
    @IBOutlet weak var source_cell2: UILabel?
    
    
    func configure(with news: Datum) {
        if let imageUrlString = news.image, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.img_cell2?.image = image
                    }
                }
            }.resume()
        }
        if let titleCell = title_cell2 {
            titleCell.text = news.title
        }
  
        if let spotText = news.spot {
            let spotLines = spotText.components(separatedBy: .newlines)
            if !spotLines.isEmpty {
                spot_cell2?.text = spotLines[0]
            } else {
                spot_cell2?.text = spotText
            }
        } else {
            spot_cell2?.text = nil
        }
        
        if let date = news.publishedDate {
            publishedDate_cell2?.text = date
        } else {
            publishedDate_cell2!.text = nil
        }
        
        if let source = news.source {
            source_cell2?.text = source.name.rawValue
        } else {
            source_cell2!.text = "Unknown Source"
        }
    }
}
