//
//  TableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 4.03.2024.
//

import UIKit

class ExploreNewsViewCell: UITableViewCell {
    static let identifier = "ExploreNewsViewCell"
    @IBOutlet weak var imgExploreNewsCell: UIImageView!
    @IBOutlet weak var titleExploreNewsCell: UILabel!
    @IBOutlet weak var publishedDateExploreNewsCell: UILabel!
    @IBOutlet weak var sourceExploreNewsCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setExploreNewsWithValuesOf(_ explores: ExploreDataClass) {
        self.titleExploreNewsCell.text = explores.title
        self.publishedDateExploreNewsCell.text = explores.publishedDate
        
        // Resim indirme işlemini buraya ekleyebilirsiniz.
        if let urlString = explores.image, let imageURL = URL(string: urlString) {
            getImageDataFrom(url: imageURL)
        } else {
            self.imgExploreNewsCell.image = UIImage(named: "noImageAvailable")
        }
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
                    self.imgExploreNewsCell.image = image
                }
            }
        }.resume()
    }
}
