//
//  Top5TableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 4.03.2024.
//

import UIKit
import SnapKit

class Top5TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let idendifier = "Top5TableViewCell"
    private var collectionViewTop5 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
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
        layout.itemSize = CGSize(width: screenWidth * 0.3, height: screenWidth * 0.45)
        collectionViewTop5 = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionViewTop5.register(Top5CollectionViewCell.self, forCellWithReuseIdentifier: Top5CollectionViewCell.identifierTop5 )
        collectionViewTop5.delegate = self
        collectionViewTop5.dataSource = self
        contentView.addSubview(collectionViewTop5)
        collectionViewTop5.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
extension Top5TableViewCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top5CollectionViewCell.identifierTop5, for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
}
