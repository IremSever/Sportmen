//
//  VideosTableViewCell.swift
//  Sportmen
//
//  Created by IREM SEVER on 15.02.2024.
//

import UIKit

class VideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    func setCellWithValuesOf(_ videos: VideoResponse) {
        
        self.videoTitleLabel.text = videos.title
        self.publishedDateLabel.text = videos.publishDate?.description
        
        guard let urlString = videos.images?.standard, let imageURL = URL(string: urlString) else {
            self.videoImageView.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.videoImageView.image = nil
        getImageDataFrom(url: imageURL)
        
        // Corner Radius - Image
        self.videoImageView.layer.cornerRadius = 20
        self.videoImageView.clipsToBounds = true
        
        // Shadow - Title
        self.videoTitleLabel.layer.shadowColor = UIColor.systemGreen.cgColor
        self.videoTitleLabel.layer.shadowOpacity = 0.2
        self.videoTitleLabel.layer.shadowOffset = CGSize(width: 0.15, height: 0.15)
        self.videoTitleLabel.layer.shadowRadius = 2
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Hata Durumu
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Videos Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.videoImageView.image = image
                }
            }
        }.resume()
    }
}
