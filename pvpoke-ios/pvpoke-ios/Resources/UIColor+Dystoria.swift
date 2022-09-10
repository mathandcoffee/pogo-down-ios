//
//  Colors+Dystoria.swift
//  mac-dysto-ios
//
//  Created by Bryan Malumphy on 10/22/21.
//

import SwiftUI

extension UIColor {
    
    static let lightPrimary: UIColor = UIColor(red: 0xAD, green: 0x47, blue: 0xFF)
    
    static let darkPrimary: UIColor = UIColor(red: 0x3F, green: 0x00, blue: 0x99)
    
    static let primary: UIColor = UIColor(red: 0x77, green: 0x00, blue: 0xCB)
    
    static let onPrimary: UIColor = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    
    static let surface: UIColor = UIColor(red: 0x23, green: 0x27, blue: 0x2A)
    
    static let background: UIColor = UIColor(red: 0x00, green: 0x00, blue: 0x00)
    
    static let lightBackground: UIColor = UIColor(red: 0x4D, green: 0x4C, blue: 0x4C)
    
    static let midBackground: UIColor = UIColor(red: 0x70, green: 0x70, blue: 0x70)
    
    static let onBackground: UIColor = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    
    static let icon: UIColor = UIColor(red: 0xD6, green: 0xD6, blue: 0xD6)
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red)/0xFF,
            green: CGFloat(green)/0xFF,
            blue: CGFloat(blue)/0xFF,
            alpha: alpha)
    }
}
