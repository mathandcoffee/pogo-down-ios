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
    
}
