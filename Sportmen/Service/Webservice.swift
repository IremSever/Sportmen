//
//  Webservice.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation

enum NewsError: Error {
    case serverError
    case parsingError
}

class Webservice {
    func downloadNews(url: URL, completion: @escaping (Result<[News], NewsError>) -> ()){
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error {
                completion(.failure(.serverError))
                return
            } else if let data = data {
                let newsList = try? JSONDecoder().decode([News].self, from: data)
                if let newsList = newsList {
                    completion(.success(newsList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
