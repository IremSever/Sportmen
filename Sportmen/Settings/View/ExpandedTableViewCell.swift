//
//  ExpandedTableViewCell.swift
//  Sportmen
//
//  Created by İrem Sever on 26.02.2024.
//

import UIKit

class ExpandedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonFontGeorgia: UIButton!
    @IBOutlet weak var buttonFontFutura: UIButton!
    @IBOutlet weak var textSlider: UISlider!
    
    var fontSize: Float = 10.0 // Default font size
    let fontSizeStep: Float = 0.25
    
    var fontChangeHandler: ((UIFont) -> Void)?
    var fontSizeChangeHandler: ((Float) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Slider value change event
        textSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        // Font change button actions
        buttonFontGeorgia.addTarget(self, action: #selector(georgiaButtonTapped), for: .touchUpInside)
        buttonFontFutura.addTarget(self, action: #selector(futuraButtonTapped), for: .touchUpInside)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        // Calculate new font size based on slider value
        let newFontSize = CGFloat(sender.value)
        fontChangeHandler?(UIFont.systemFont(ofSize: newFontSize))
    }
    
    // Change the size accordingly
    @objc func georgiaButtonTapped() {
        fontSize += fontSizeStep // Increase font size by step
        fontChangeHandler?(UIFont(name: "Georgia", size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize)))
    }
    
    // Change the size accordingly
    @objc func futuraButtonTapped() {
        fontSize += fontSizeStep // Increase font size by step
        fontChangeHandler?(UIFont(name: "Futura", size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize)))
    }
}
