//
//  PopularTopicsTableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 5.03.2024.
//

import UIKit

class PopularTopicsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let identifier = "PopularTopicsTableViewCell"
    private var collectionViewPopularTopics: UICollectionView!
    var exploreDataArray: [ExploreDataClass] = []
    
    let listPopularTopic = ["Süper Lig", "Fenerbahçe", "Real Madrid", "İsmail Kartal", "Konferans Ligi", "Ferdi Kadıoğlu", "Uefa Şampiyonlar Ligi", "Milli Takım"]
    
    let cellColors: [UIColor] = [.systemGreen,
                                .blue, .purple,
                                 .orange, .systemRed,
                                 .systemGray,
                                 .magenta, .brown]
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createPopularTopicsCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func createPopularTopicsCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.width * 0.30)
        
        collectionViewPopularTopics = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewPopularTopics.register(PopularTopicsCollectionViewCell.self, forCellWithReuseIdentifier: PopularTopicsCollectionViewCell.identifierPopularTopics)
        collectionViewPopularTopics.delegate = self
        collectionViewPopularTopics.dataSource = self
        collectionViewPopularTopics.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionViewPopularTopics)
        
        collectionViewPopularTopics.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPopularTopic.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularTopicsCollectionViewCell.identifierPopularTopics, for: indexPath) as? PopularTopicsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let colorIndex = indexPath.item % cellColors.count
        cell.backgroundColor = cellColors[colorIndex]
        cell.titlePopularTopic.text = listPopularTopic[indexPath.item]
        return cell
    }
    
}
