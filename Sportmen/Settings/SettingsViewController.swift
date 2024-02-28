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
    
    var isExpanded = false // Button
    var isSwitch = false
    var expandedIndexPath: IndexPath?
    var isExpandedCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.sectionHeaderTopPadding = 0
        registerTableCells()
        navigationBarDesign()
    }
    
    func registerTableCells() {
        settingsTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        settingsTableView.register(UINib(nibName: "StandartTableViewCell", bundle: nil), forCellReuseIdentifier: "StandartTableViewCell")
        settingsTableView.register(UINib(nibName: "ExpandedTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandedTableViewCell")
    }
    
    func enableDarkMode() {
        self.settingsTableView.backgroundColor = .black
        self.view.backgroundColor = .black
        self.tabBarController?.tabBar.barTintColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    func disableDarkMode() {
        self.settingsTableView.backgroundColor = .white
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    func navigationBarDesign() {
        let imgAppIcon = UIImageView(image: UIImage(named: "icon_mainmenu"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgAppIcon)
        
        let lblTitleCategory = "Settings"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: lblTitleCategory)
        
        settingsTableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accounts.count
        case 1:
            if isExpandedCell && expandedIndexPath?.section == 1 {
                return moreFeatures.count + 1
            } else {
                return moreFeatures.count
            }
        case 2:
            return support.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == moreFeatures.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandedTableViewCell", for: indexPath) as! ExpandedTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandartTableViewCell", for: indexPath) as! StandartTableViewCell
            
            switch indexPath.section {
            case 0:
                cell.switchDarkMode.isHidden = !isSwitch
                cell.buttonExpandCell.isHidden = !isExpanded
                cell.lblStandartCell.text = accounts[indexPath.row]
            case 1:
                if indexPath.row == 0 {
                    cell.lblStandartCell.text = moreFeatures[indexPath.row]
                    cell.switchDarkMode.isHidden = (moreFeatures[indexPath.row] != "Dark Mode")
                    cell.buttonExpandCell.isHidden = !isExpanded
                    cell.switchDarkMode.isOn = isSwitch // Switch durumunu güncelle
                } else if indexPath.row == 1 {
                    cell.lblStandartCell.text = moreFeatures[indexPath.row]
                    cell.switchDarkMode.isHidden = !isSwitch
                    cell.buttonExpandCell.isHidden = (moreFeatures[indexPath.row] != "Text Style")
                } else {
                    isExpanded = true
                    cell.buttonExpandCell.isHidden = true
                }
            case 2:
                cell.switchDarkMode.isHidden = !isSwitch
                cell.buttonExpandCell.isHidden = !isExpanded
                cell.lblStandartCell.text = support[indexPath.row]
            default:
                return UITableViewCell()
            }
            cell.switchHandler = { [weak self] isDarkMode in
                if isDarkMode {
                    self?.enableDarkMode()
                } else {
                    self?.disableDarkMode()
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        cell.settingsTitles.font = UIFont.boldSystemFont(ofSize: 20)
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        cell.settingsTitles.text = headers[section]
        
        if section == 1 && isExpandedCell {
            let expandLabel = UILabel(frame: CGRect(x: 10, y: 30, width: 100, height: 20))
            expandLabel.font = UIFont.systemFont(ofSize: 15)
            expandLabel.textColor = .black
            expandLabel.text = "Text Style"
            cell.contentView.addSubview(expandLabel)
        }
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == moreFeatures.count && isExpanded {
            return 115
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
