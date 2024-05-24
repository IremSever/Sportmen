//
//  VideosWebService.swift
//  Sportmen
//
//  Created by IREM SEVER on 15.02.2024.
//

import Foundation
class VideosWebservice {
    func getVideosData(completion: @escaping (Result<Videos, Error>) -> Void) {
        let videosURL = "https://....."
        guard let url = URL(string: videosURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Videos Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Videos Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Videos.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
