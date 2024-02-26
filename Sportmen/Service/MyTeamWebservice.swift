//
//  MyTeamWebservice.swift
//  Sportmen
//
//  Created by İrem Sever on 26.02.2024.
//

import Foundation

class MyTeamWebservice {
    func getMyTeamData (completion: @escaping (Result<MyTeam, Error>) -> Void) {
        let myTeamURL = "https://api.tmgrup.com.tr/aggregator/contents?pagetype=5&app=2&teamId="
        guard let url = URL(string: myTeamURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("MyTeam Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("MyTeam Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MyTeam.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}


