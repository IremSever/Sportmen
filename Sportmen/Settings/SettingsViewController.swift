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
    
    var isExpanded = false
    var isSwitch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.sectionHeaderTopPadding = 0
        registerTableCells()
    }
    
    func registerTableCells() {
            settingsTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
            settingsTableView.register(UINib(nibName: "StandartTableViewCell", bundle: nil), forCellReuseIdentifier: "StandartTableViewCell")
            settingsTableView.register(UINib(nibName: "ExpandedTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandedTableViewCell")
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
                return moreFeatures.count
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
                cell.switchDarkMode.isHidden = !isSwitch
                cell.buttonExpandCell.isHidden = !isExpanded
                switch indexPath.section {
                case 0:
                    cell.lblStandartCell.text = accounts[indexPath.row]
                case 1:
                    if indexPath.row == 0 {
                        cell.lblStandartCell.text = moreFeatures[indexPath.row]
                    } else if indexPath.row == 1 {
                        cell.lblStandartCell.text = moreFeatures[indexPath.row]
                    }
                case 2:
                    cell.lblStandartCell.text = support[indexPath.row]
                default:
                    return UITableViewCell()
                }
                return cell
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 1 && indexPath.row == moreFeatures.count {
                isExpanded.toggle()
                tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
            cell.settingsTitles.font = UIFont.boldSystemFont(ofSize: 20)
            cell.backgroundColor = .white
            cell.contentView.backgroundColor = .white
            cell.settingsTitles.text = headers[section]
            
            if section == 1 && isExpanded {
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
