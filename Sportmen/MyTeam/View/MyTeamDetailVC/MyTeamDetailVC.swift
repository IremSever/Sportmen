//
//  MyTeamDetailVC.swift
//  Sportmen
//
//  Created by İrem Sever on 27.02.2024.
//

import UIKit

class MyTeamDetailVC: UIViewController {

    var selectedMyTeam: DataClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myTeam = selectedMyTeam {
            setMyTeamDetailWithValuesOf(myTeam)
        }
    }
    
    func setMyTeamDetailWithValuesOf(_ myTeam: DataClass) {
     
        
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("MyTeam Data")
                return
            }
        
        }.resume()
    }
}


