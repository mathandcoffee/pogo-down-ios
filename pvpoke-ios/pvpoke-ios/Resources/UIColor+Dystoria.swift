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
    
    static func getColorForPokemonType(pokemonType: PokemonType) -> UIColor {
        switch pokemonType {
        case .bug:
            return UIColor(red: 0x9B, green: 0xC2, blue: 0x31)
        case .dark:
            return UIColor(red: 0x52, green: 0x50, blue: 0x5E)
        case .dragon:
            return UIColor(red: 0x10, green: 0x65, blue: 0xb6)
        case .electric:
            return UIColor(red: 0xF3, green: 0xD4, blue: 0x3E)
        case .fairy:
            return UIColor(red: 0xEB, green: 0x3D, blue: 0xE1)
        case .fighting:
            return UIColor(red: 0xCE, green: 0x3D, blue: 0x64)
        case .fire:
            return UIColor(red: 0xFE, green: 0x9D, blue: 0x59)
        case .flying:
            return UIColor(red: 0x91, green: 0xA8, blue: 0xDE)
        case .ghost:
            return UIColor(red: 0x50, green: 0x69, blue: 0xAC)
        case .grass:
            return UIColor(red: 0x5F, green: 0xBB, blue: 0x50)
        case .ground:
            return UIColor(red: 0xD8, green: 0x7B, blue: 0x40)
        case .ice:
            return UIColor(red: 0x74, green: 0xD3, blue: 0xBD)
        case .normal:
            return UIColor(red: 0x90, green: 0x9A, blue: 0xA3)
        case .poison:
            return UIColor(red: 0xC6, green: 0x62, blue: 0xD6)
        case .psychic:
            return UIColor(red: 0xF2, green: 0x72, blue: 0x6F)
        case .rock:
            return UIColor(red: 0xC7, green: 0xB9, blue: 0x8C)
        case .steel:
            return UIColor(red: 0x50, green: 0x87, blue: 0x9C)
        case .water:
            return UIColor(red: 0x4F, green: 0x91, blue: 0xDB)
        case .none:
            return UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
        }
    }
}
