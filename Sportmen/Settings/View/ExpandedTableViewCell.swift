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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textSlider.minimumValue = 0
        textSlider.maximumValue = 100
        textSlider.value = 50
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFonts), name: Notification.Name("FontSizeChanged"), object: nil)
        
        textSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        buttonFontGeorgia.addTarget(self, action: #selector(increaseFontSize), for: .touchUpInside)
        buttonFontFutura.addTarget(self, action: #selector(decreaseFontSize), for: .touchUpInside)
        buttonFontGeorgia.addTarget(self, action: #selector(setFontGeorgia), for: .touchUpInside)
        buttonFontFutura.addTarget(self, action: #selector(setFontFutura), for: .touchUpInside)
    }
    
    @objc func updateFonts() {
        buttonFontGeorgia.titleLabel?.font = UIFont.getAppFont()
        buttonFontFutura.titleLabel?.font = UIFont.getAppFont()
    }
    
    @objc func increaseFontSize() {
        UIFont.increaseFontSize()
    }
    
    @objc func decreaseFontSize() {
        UIFont.decreaseFontSize()
    }
    
    @objc func sliderValueChanged() {
        let value = CGFloat(textSlider.value)
        let normalizedValue = value / 100.0
        
        let minFontSize: CGFloat = 12.0
        let maxFontSize: CGFloat = 30.0
        let fontSizeRange = maxFontSize - minFontSize
        
        let newFontSize = minFontSize + (normalizedValue * fontSizeRange)
        
        UIFont.currentFontSize = newFontSize
        
        NotificationCenter.default.post(name: Notification.Name("FontSizeChanged"), object: nil)
    }
    
    @objc func setFontGeorgia() {
        UIFont.setAppFont(style: .georgia)
        NotificationCenter.default.post(name: Notification.Name("FontSizeChanged"), object: nil)
    }
    
    @objc func setFontFutura() {
        UIFont.setAppFont(style: .futura)
        NotificationCenter.default.post(name: Notification.Name("FontSizeChanged"), object: nil)
    }
}

extension UIFont {
    enum FontStyle {
        case georgia
        case futura
    }
    
    static var currentFontSize: CGFloat = 17.0
    static var currentFontStyle: FontStyle = .georgia
    
    static func increaseFontSize() {
        currentFontSize += 1.0
        NotificationCenter.default.post(name: Notification.Name("FontSizeChanged"), object: nil)
    }
    
    static func decreaseFontSize() {
        currentFontSize -= 1.0
        NotificationCenter.default.post(name: Notification.Name("FontSizeChanged"), object: nil)
    }
    
    static func setAppFont(style: FontStyle) {
        currentFontStyle = style
    }
    
    static func getAppFont() -> UIFont {
        switch currentFontStyle {
        case .georgia:
            return UIFont(name: "Georgia", size: currentFontSize) ?? UIFont.systemFont(ofSize: currentFontSize)
        case .futura:
            return UIFont(name: "Futura", size: currentFontSize) ?? UIFont.systemFont(ofSize: currentFontSize)
        }
    }
}
