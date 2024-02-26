//
//  ExpandedTableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 26.02.2024.
//

import UIKit

class ExpandedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelLargeA: UILabel!
    @IBOutlet weak var labelSmallA: UILabel!
    @IBOutlet weak var buttonFontGeorgia: UIButton!
    @IBOutlet weak var buttonFontFutura: UIButton!
    @IBOutlet weak var textSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
