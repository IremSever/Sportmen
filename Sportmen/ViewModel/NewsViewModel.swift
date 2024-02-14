//
//  NewsViewModel.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation

class NewsViewModel {
    private var webService = Webservice()
    private var news = [News]()
    
    func fetchNewsData(completion: @escaping() -> ()) {
        webService.getNewsData{ [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.news = listOf.news
                completion()
            case .failure(let error):
                print("Error proccessing json data: \(error)")
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if news.count != 0 {
            return news.count
        }
        return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> News {
        return news[indexPath.row]
    }
}
