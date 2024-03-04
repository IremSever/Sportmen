//
//  ExploreViewModel.swift
//  Sportmen
//
//  Created by İrem Sever on 3.03.2024.
//

import Foundation
import UIKit

class ExploreViewModel {
    private var exploreWebService = ExploreWebservice()
    private var explores = [ExploreDataClass]()
    private var filteredExplore: [ExploreDataClass] = []
    
    func getExploreData() -> [ExploreDataClass] {
        return explores
    }
    
    func fetchExploreData(completion: @escaping () -> Void) {
        exploreWebService.getExploreData { [weak self] result in
            switch result {
            case .success(let exploreData):
                self?.explores = exploreData.data
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}

extension ExploreViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func upSearchController(searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(), !searchText.isEmpty else {
            filteredExplore = explores
            return
        }
        filteredExplore = explores.filter { $0.title?.lowercased().contains(searchText) ?? false }
    }
}
