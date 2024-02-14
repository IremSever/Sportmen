//
//  NewsTableViewCell.swift
//  Sportmen
//
//  Created by IREM SEVER on 14.02.2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImgCell1: UIImageView!
//    
    @IBOutlet weak var newsTtleCell1: UILabel!
    
    @IBOutlet weak var newsSourceCell1: UILabel!
    
    
    // Setup news values
    func setCellWithValuesOf(_ news: News) {
        updateUI(title: news.title, source: news.source, image: news.image)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, source: String?, image: String?) {
        self.newsTtleCell1.text = title
        self.newsSourceCell1.text = source
        
        guard let urlString = image, let imageURL = URL(string: urlString) else {
            self.newsImgCell1.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.newsImgCell1.image = nil
        getImageDataFrom(url: imageURL)
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.newsImgCell1.image = image
                }
            }
        }.resume()
    }
}
