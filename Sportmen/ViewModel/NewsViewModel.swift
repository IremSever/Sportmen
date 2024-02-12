//
//  NewsViewModel.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation
import Combine

class NewsViewModel {
    
    let news = PassthroughSubject<News, Never>()
    let error = PassthroughSubject<String, Never>()
    let loading = PassthroughSubject<Bool, Never>()
    
    func requestData() {
        self.loading.send(true)
        
        let url = URL(string: "https://api.tmgrup.com.tr/aggregator/contents?pagetype=0&app=2")!
        Webservice().downloadNews(url: url) { result in
            self.loading.send(false)
            switch result {
            case .success(let news):
                self.news.send(news)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.send("Parsing Error")
                case .serverError:
                    self.error.send("Server Error")
                }
            }
        }
    }
}
