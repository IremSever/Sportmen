//
//  ExploreViewController.swift
//  Sportmen
//
//  Created by İrem Sever on 29.02.2024.
//

import Foundation
import UIKit
import SnapKit

class ExploreViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreViewModel = ExploreViewModel()
    private var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        exploreTableView.register(Top5TableViewCell.self, forCellReuseIdentifier: Top5TableViewCell.idendifier)
        loadExploreData()
        setupSearchController()
        navigationBarDesign()
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
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Explore"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exploreTableView.dequeueReusableCell(withIdentifier: Top5TableViewCell.idendifier, for: indexPath) as! Top5TableViewCell
        let exploreData = exploreViewModel.cellForRowAt(indexPath: indexPath)
        cell.updateDataArray(with: [exploreData])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    // MARK: - Search Controller
    @objc(updateSearchResultsForSearchController:) func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        exploreViewModel.upSearchController(searchBarText: searchText)
        exploreTableView.reloadData()
    }
}


