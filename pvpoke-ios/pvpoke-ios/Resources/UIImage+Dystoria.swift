//
//  UIImage+Dystoria.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 10/23/21.
//

import UIKit

extension UIImage {
    fileprivate static func imageWithName(_ name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("No image with name \(name)")
        }
        return image
    }
    
    // MARK: Icons
    
    static var back: UIImage {
        return imageWithName("back").withRenderingMode(.alwaysTemplate)
    }
    
    static var articlesIcon: UIImage {
        return imageWithName("dashboard-dashboard_symbol")
    }
    
    static var teamBuilderIcon: UIImage {
        return imageWithName("atr-atr_symbol")
    }
    
    static var infoIcon: UIImage {
        return imageWithName("info-info_symbol")
    }
    
    static var settingsIcon: UIImage {
        return imageWithName("settings-settings_symbol")
    }
    
    static var logo: UIImage {
        return imageWithName("logo")
    }
    
    static var edit: UIImage {
        return imageWithName("edit")
    }
}
