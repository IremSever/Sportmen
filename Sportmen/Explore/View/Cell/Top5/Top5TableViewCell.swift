//
//  Top5TableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 4.03.2024.
//

import UIKit
import SnapKit

class Top5TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "Top5TableViewCell"
    private var collectionViewTop5: UICollectionView!
    var exploreDataArray: [ExploreDataClass] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createExploreCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createExploreCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.7)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 15
        
        collectionViewTop5 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTop5.register(Top5CollectionViewCell.self, forCellWithReuseIdentifier: Top5CollectionViewCell.identifierTop5)
        collectionViewTop5.delegate = self
        collectionViewTop5.dataSource = self
        collectionViewTop5.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionViewTop5)
        
        collectionViewTop5.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateDataArray(with newDataArray: [ExploreDataClass]) {
        exploreDataArray = newDataArray
        collectionViewTop5.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top5CollectionViewCell.identifierTop5, for: indexPath) as? Top5CollectionViewCell else {
            return UICollectionViewCell()
        }
        let exploreData = exploreDataArray[indexPath.item]
        cell.configure(with: exploreData)
        return cell
    }
}
