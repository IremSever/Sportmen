//
//  PopularTopicsCollectionViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 5.03.2024.
//

import UIKit

class PopularTopicsCollectionViewCell: UICollectionViewCell {
    static let identifierPopularTopics = "PopularTopicsCollectionViewCell"
    
    let titlePopularTopic: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titlePopularTopic)
        titlePopularTopic.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview() 
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
