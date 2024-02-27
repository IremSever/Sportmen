//
//  StandartTableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 27.02.2024.
//

import UIKit

class StandartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonExpandCell: UIButton!
    @IBOutlet weak var switchDarkMode: UISwitch!
    @IBOutlet weak var lblStandartCell: UILabel!
    var switchHandler: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchDarkMode.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        switchHandler?(sender.isOn)
    }
}
