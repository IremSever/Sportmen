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
          print("************",sender.value)
          
          if Int(sender.value) == 1 {
              fontSizeChangeHandler?(13)
          } else if Int(sender.value) == 2 {
              fontSizeChangeHandler?(15)
          } else if Int(sender.value) == 3 {
              fontSizeChangeHandler?(17)
          } else if Int(sender.value) == 4 {
              fontSizeChangeHandler?(18)
          } else {
              fontSizeChangeHandler?(20)
          }
      }
      
      // Change the size accordingly
      @objc func georgiaButtonTapped() {
          if let fontChangeHandler = fontChangeHandler {
              fontChangeHandler(UIFont(name: "Georgia", size: 17.0)!)
          }
      }
      
      // Change the size accordingly
      @objc func futuraButtonTapped() {
          if let fontChangeHandler = fontChangeHandler {
              fontChangeHandler(UIFont(name: "Futura", size: 17.0)!)
          }
      }
  }
