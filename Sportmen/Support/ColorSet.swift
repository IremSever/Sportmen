//
//  ColorSet.swift
//  Sportmen
//
//  Created by İrem Sever on 29.02.2024.
//

import UIKit

class ColorSet: NSObject {
    static let shared = ColorSet()
    
    func getSettingsBgColor() -> UIColor {
        return UIColor(named: "settingsBgColor") ?? .black
    }
    
}
