//
//  ExploreViewController.swift
//  Sportmen
//
//  Created by İrem Sever on 29.02.2024.
//

import Foundation
import UIKit
import SnapKit

class ExploreViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreViewModel = ExploreViewModel()
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exploreTableView.dataSource = self
        self.exploreTableView.delegate = self
        self.exploreTableView.register(Top5TableViewCell.self, forCellReuseIdentifier: Top5TableViewCell.idendifier)
        loadExploreData()
        view.addSubview(exploreTableView)
        exploreTableView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
        navigationBarDesign()
        setupSearchController()
    }
    
    private func loadExploreData() {
        exploreViewModel.fetchExploreData { [weak self] in
            DispatchQueue.main.async {
                self?.exploreTableView.reloadData()
            }
        }
    }
    
    func navigationBarDesign() {
        let imgAppIcon = UIImageView(image: UIImage(named: "icon_mainmenu"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgAppIcon)
        
        let lblTitleCategory = "Explore"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: lblTitleCategory, style: .plain, target: nil, action: nil)
        
        exploreTableView.reloadData()
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Explore"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension ExploreViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exploreTableView.dequeueReusableCell(withIdentifier: Top5TableViewCell.idendifier, for: indexPath) as! Top5TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //exploreViewModel.filterContentForSearchText(searchBar.text)
        exploreTableView.reloadData()
    }
}
