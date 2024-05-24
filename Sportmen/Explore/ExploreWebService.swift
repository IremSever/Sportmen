//
//  ExploreWebService.swift
//  Sportmen
//
//  Created by İrem Sever on 3.03.2024.
//

import Foundation

class ExploreWebservice {
    func getExploreData(completion: @escaping (Result<Explore, Error>) -> Void) {
        let newsURL = "https://....."
        guard let url = URL(string: newsURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Explore Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Explore Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Explore.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
