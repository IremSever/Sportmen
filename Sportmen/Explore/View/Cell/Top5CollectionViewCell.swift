//
//  Top5CollectionViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 3.03.2024.
//

import UIKit

class Top5CollectionViewCell: UICollectionViewCell {
    static let identifierTop5 = "Top5CollectionViewCell"
    
    private let imgTop5: UIImageView = {
        let imgTop5 = UIImageView()
        imgTop5.contentMode = .scaleAspectFill
        imgTop5.clipsToBounds = true
        return imgTop5
    }()
    
    private let titleTop5: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgTop5)
        contentView.addSubview(titleTop5)
        imgTop5.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgTop5.frame = contentView.bounds
        titleTop5.frame = CGRect(x: 0, y: imgTop5.frame.maxY, width: contentView.frame.width, height: 30)
        
        self.imgTop5.layer.cornerRadius = 20
        self.imgTop5.clipsToBounds = true
        
        self.titleTop5.layer.shadowColor = UIColor.systemGreen.cgColor
        self.titleTop5.layer.shadowOpacity = 0.2
        self.titleTop5.layer.shadowOffset = CGSize(width: 0.15, height: 0.15)
        self.titleTop5.layer.shadowRadius = 2
    }
    
    func configure(with exploreData: ExploreDataClass?) {
        guard let imageURLString = exploreData?.image,
              let imageURL = URL(string: imageURLString) else {
            imgTop5.image = nil
            titleTop5.text = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgTop5.image = image
            }
        }.resume()
        
        titleTop5.text = exploreData?.title
    }
    
    
}
