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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
