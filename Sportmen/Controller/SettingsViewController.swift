//
//  SettingsViewController.swift
//  Sportmen
//
//  Created by İrem Sever on 23.02.2024.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    let headers = ["Account", "More Features", "Support"]
    let accounts = ["Teams", "News Souces", "Notifications"]
    let moreFeatures = ["Dark Mode", "Text Style"]
    let support = ["Privacy Policy", "Clarification Text", "Contact Us"]
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.sectionHeaderTopPadding = 0
        registerTableCells()
    }
    
    func registerTableCells(){
        settingsTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
    }
}

extension SettingsViewController: UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accounts.count
        case 1:
            return moreFeatures.count
        case 2:
            return support.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        cell.settingsTitles.font = UIFont.systemFont(ofSize: 15)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        switch indexPath.section {
        case 0:
            cell.settingsTitles.text = accounts[indexPath.row]
        case 1:
            cell.settingsTitles.text = moreFeatures[indexPath.row]
        case 2:
            cell.settingsTitles.text = support[indexPath.row]
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        cell.settingsTitles.font = UIFont.boldSystemFont(ofSize: 20)
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        cell.settingsTitles.text = headers[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 40
        case 2:
            return 40
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 20
        case 2:
            return 20
        default:
            return 20
        }
    }
}