//
//  NewsTableViewCell.swift
//  Sportmen
//
//  Created by IREM SEVER on 14.02.2024.
//

import UIKit

class NewsTableViewCell1: UITableViewCell {
    //cell1
    @IBOutlet weak var newsImgCell1: UIImageView!
    
    @IBOutlet weak var newsTtleCell1: UILabel!
    
    @IBOutlet weak var newsSourceCell1: UILabel!
    
    func setCell1WithValuesOf(_ news: Datum) {
        self.newsTtleCell1.text = news.title
        self.newsSourceCell1.text = news.source?.name.rawValue
        
        guard let urlString = news.image, let imageURL = URL(string: urlString) else {
            self.newsImgCell1.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.newsImgCell1.image = nil
        getImageDataFrom(url: imageURL, forCell: 1)
    }
    
    private func getImageDataFrom(url: URL, forCell cellNumber: Int) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle News Data
                print("News Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    if cellNumber == 1 {
                        self.newsImgCell1.image = image
                    } 
                }
            }
        }.resume()
    }
}
