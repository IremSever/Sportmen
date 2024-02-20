//
//  NewsTableViewCell2.swift
//  Sportmen
//
//  Created by IREM SEVER on 16.02.2024.
//

import UIKit

class NewsTableViewCell2: UITableViewCell {

    //cell2
    @IBOutlet weak var newsImgCell2: UIImageView!
    
    @IBOutlet weak var newsSourceCell2: UILabel!
    
    @IBOutlet weak var newsPublishedDateCell2: UILabel!
    
    @IBOutlet weak var newsTitleCell2: UILabel!
    
    //@IBOutlet weak var newsSpotCell2: UILabel!
    
    func setCell2WithValuesOf(_ news: Datum) {
        self.newsTitleCell2.text = news.title
        self.newsSourceCell2.text = news.source?.name.rawValue
        //self.newsSpotCell2.text = news.spot
        self.newsPublishedDateCell2.text = news.publishedDate
        
        guard let urlString = news.image, let imageURL = URL(string: urlString) else {
            self.newsImgCell2.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.newsImgCell2.image = nil
        getImageDataFrom(url: imageURL, forCell: 2)
        
        // Corner Radius - Image
        self.newsImgCell2.layer.cornerRadius = 10
        self.newsImgCell2.clipsToBounds = true
        
        
        // Shadow - Title
        self.newsTitleCell2.layer.shadowColor = UIColor.systemGreen.cgColor
        self.newsTitleCell2.layer.shadowOpacity = 0.2
        self.newsTitleCell2.layer.shadowOffset = CGSize(width: 0.15, height: 0.15)
        self.newsTitleCell2.layer.shadowRadius = 2
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
                    if cellNumber == 2 {
                        self.newsImgCell2.image = image
                    }
                }
            }
        }.resume()
    }
}
