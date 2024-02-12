//
//  NewsViewModel.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

class NewsViewModel {
    
    let news: PublishSubject<News> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData(){
        self.loading.onNext(true)
        
        let url = URL(string: "https://api.tmgrup.com.tr/aggregator/contents?pagetype=0&app=2")!
        Webservice().downloadNews(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case.success(let news):
                self.news.onNext(news)
            case.failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
        
    }
}
