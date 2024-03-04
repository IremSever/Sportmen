//
//  Top5CollectionViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 3.03.2024.
//

import UIKit

class Top5CollectionViewCell: UICollectionViewCell {
    static let identifierTop5 = "Top5CollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with exploreData: ExploreDataClass?) {
        guard let imageURLString = exploreData?.image,
              let imageURL = URL(string: imageURLString) else {
            imageView.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }.resume()
    }
}
