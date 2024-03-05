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
    let headers = ["Top 5", "Popular Topics", "Selected Topic"]
    private var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        registerTableCells()
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
    
    func registerTableCells() {
        exploreTableView.register(Top5TableViewCell.self, forCellReuseIdentifier: Top5TableViewCell.identifier)
        exploreTableView.register(ExploreNewsViewCell.self, forCellReuseIdentifier: ExploreNewsViewCell.identifier)
        exploreTableView.register(ExploreHeadersTableViewCell.self, forCellReuseIdentifier: ExploreHeadersTableViewCell.identifier)
        exploreTableView.register(PopularTopicsTableViewCell.self, forCellReuseIdentifier: PopularTopicsTableViewCell.identifier)
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
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
extension ExploreViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = exploreTableView.dequeueReusableCell(withIdentifier: Top5TableViewCell.identifier, for: indexPath) as! Top5TableViewCell
            cell.updateDataArray(with: exploreViewModel.getExploreData())
            return cell
        case 1:
            let cell = exploreTableView.dequeueReusableCell(withIdentifier: PopularTopicsTableViewCell.identifier, for: indexPath) as! PopularTopicsTableViewCell
            return cell
        case 2:
            let cell = exploreTableView.dequeueReusableCell(withIdentifier: ExploreNewsViewCell.identifier, for: indexPath) as! ExploreNewsViewCell
            
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        else if indexPath.section == 1 {
            return 150
        } else {
            return 500
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        exploreViewModel.upSearchController(searchBarText: searchText)
        exploreTableView.reloadData()
    }
}
