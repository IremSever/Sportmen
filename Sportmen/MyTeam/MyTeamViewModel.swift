//
//  MyTeamViewModel.swift
//  Sportmen
//
//  Created by İrem Sever on 27.02.2024.
//

import Foundation

class MyTeamViewModel {
    private var myTeamWebService = MyTeamWebservice()
    private var myTeam = [DataClass]()
    
    func fetchMyTeamData(completion: @escaping () -> Void) {
        myTeamWebService.getMyTeamData { [weak self] result in
            switch result {
            case .success(let myTeamData):
                self?.myTeam = myTeamData.data
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return myTeam.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> DataClass {
        return myTeam[indexPath.row]
    }
}
