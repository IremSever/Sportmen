//
//  MyTeamViewController.swift
//  Sportmen
//
//  Created by İrem Sever on 27.02.2024.
//

import Foundation
import UIKit

class MyTeamViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTeamTableView: UITableView!
    let myTeamViewModel = MyTeamViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTeamTableView.dataSource = self
        self.myTeamTableView.delegate = self
        loadVideoData()
    }
    private func loadVideoData() {
        myTeamViewModel.fetchMyTeamData { [weak self] result in
            DispatchQueue.main.async {
                self?.myTeamTableView.reloadData()
            }
        }
    }
    
    func showVideosDetail(_ myTeam: DataClass) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let myTeamDetailVC = storyboard.instantiateViewController(withIdentifier: "MyTeamDetailVC") as? MyTeamDetailVC {
            myTeamDetailVC.selectedVideos = myTeam
            navigationController?.pushViewController(myTeamDetailVC, animated: true)
        }
    }
    
}

extension MyTeamViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
