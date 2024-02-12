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
        let cell = NewsTableViewCell(style: .default, reuseIdentifier: "NewsCell")
        let news = newsList[indexPath.row]
        cell.configure(with: news)
        return cell
    }
}

class NewsTableViewCell: UITableViewCell {
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let spotLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(spotLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            newsImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            spotLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            spotLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            spotLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: Datum) {
        if let imageUrlString = news.image, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.newsImageView.image = image
                    }
                }
            }.resume()
        }
        
        titleLabel.text = news.title
        
        if let spotText = news.spot {
            let spotLines = spotText.components(separatedBy: .newlines)
            if !spotLines.isEmpty {
                spotLabel.text = spotLines[0]
            } else {
                spotLabel.text = spotText
            }
        } else {
            spotLabel.text = nil
        }
    }
}
