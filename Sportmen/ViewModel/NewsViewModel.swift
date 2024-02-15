//
//  NewsViewModel.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation

class NewsViewModel {
    private var newsWebService = NewsWebservice()
    private var news = [Datum]()
    
    func fetchNewsData(completion: @escaping() -> ()) {
        newsWebService.getNewsData { [weak self] result in
            switch result {
            case .success(let newsData):
                self?.news = newsData.data
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return news.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Datum {
        return news[indexPath.row]
    }
}
