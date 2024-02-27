//
//  NewsDetailVC.swift
//  Sportmen
//
//  Created by İrem Sever on 19.02.2024.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    @IBOutlet weak var newsDetailImg: UIImageView!
    
    @IBOutlet weak var newsDetailTitle: UILabel!
    
    @IBOutlet weak var newsDetailSource: UILabel!
    
    @IBOutlet weak var newsDetailSpot: UILabel!
    @IBOutlet weak var newsDetailOublishedDate: UILabel!
    
    var selectedNews: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let news = selectedNews {
            setNewsDetailWithValuesOf(news)
        }
    }
    
    func setNewsDetailWithValuesOf(_ news: Datum) {
        self.newsDetailTitle.text = news.title
        self.newsDetailSource.text = news.source?.name.rawValue
        self.newsDetailSpot.text = news.spot
        self.newsDetailOublishedDate.text = news.publishedDate
        
        guard let urlString = news.image, let imageURL = URL(string: urlString) else {
            self.newsDetailImg.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.newsDetailImg.image = nil
        getImageDataFrom(url: imageURL)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("News Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.newsDetailImg.image = image
                    
                }
            }
        }.resume()
    }
}
