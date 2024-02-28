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
        loadMyTeamData()
        
        navigationBarDesign()
    }
    
    private func loadMyTeamData() {
        myTeamViewModel.fetchMyTeamData { [weak self] in
            DispatchQueue.main.async {
                self?.myTeamTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTeamViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath)
        let data = myTeamViewModel.cellForRowAt(indexPath: indexPath)
        cell.textLabel?.text = data.standingsLink
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = myTeamViewModel.cellForRowAt(indexPath: indexPath)
        showMyTeamDetail(data)
    }
    
    func showMyTeamDetail(_ myTeam: DataClass) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let myTeamDetailVC = storyboard.instantiateViewController(withIdentifier: "MyTeamDetailVC") as? MyTeamDetailVC {
            myTeamDetailVC.selectedMyTeam = myTeam
            navigationController?.pushViewController(myTeamDetailVC, animated: true)
        }
    }
    
    func navigationBarDesign() {
        let imgAppIcon = UIImageView(image: UIImage(named: "icon_mainmenu"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgAppIcon)
        
        let buttonChangeTeam = UIButton(type: .custom)
        buttonChangeTeam.setImage(UIImage(named: "changeteams"), for: .normal)
        buttonChangeTeam.contentMode = .scaleAspectFit
        buttonChangeTeam.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        buttonChangeTeam.addTarget(self, action: #selector(buttonChangeTeamTapped), for: .touchUpInside)
        let changeTeamBarButton = UIBarButtonItem(customView: buttonChangeTeam)
        
        navigationItem.rightBarButtonItem = changeTeamBarButton
    }
    
    @objc func buttonChangeTeamTapped() {
        
        myTeamTableView.reloadData()
    }
}
