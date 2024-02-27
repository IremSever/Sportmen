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
        
        
        // Corner Radius - Image
        self.newsImgCell1.layer.cornerRadius = 20
        self.newsImgCell1.clipsToBounds = true
        
        // Shadow - Cell
        /*self.clipsToBounds = false
        self.layer.shadowColor = UIColor.systemGreen.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 50*/
        
        // Shadow - Title
        self.newsTtleCell1.layer.shadowColor = UIColor.systemGreen.cgColor
        self.newsTtleCell1.layer.shadowOpacity = 0.2
        self.newsTtleCell1.layer.shadowOffset = CGSize(width: 0.15, height: 0.15)
        self.newsTtleCell1.layer.shadowRadius = 2
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
