//
//  Webservice.swift
//  Sportmen
//
//  Created by IREM SEVER on 9.02.2024.
//

import Foundation

class Webservice {
    private var dataTask: URLSessionDataTask?
    
    func getNewsData(completion: @escaping (Result<NewsData, Error>) -> Void) {
        
        let newsURL = "https://api.tmgrup.com.tr/aggregator/contents?pagetype=0&app=2"
        guard let url = URL(string: newsURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            
            do{
                //parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsData.self, from: data)
                
                //back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
                
            }
        }
        dataTask?.resume()
    }
}
