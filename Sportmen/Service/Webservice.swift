//
//  Webservice.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation

class Webservice {
    func getNewsData(completion: @escaping (Result<Empty, Error>) -> Void) {
            let newsURL = "https://api.tmgrup.com.tr/aggregator/contents?pagetype=0&app=2"
            guard let url = URL(string: newsURL) else { return }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("Empty Response")
                    return
                }
                print("Response status code: \(response.statusCode)")

                guard let data = data else {
                    print("Empty Data")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Empty.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
