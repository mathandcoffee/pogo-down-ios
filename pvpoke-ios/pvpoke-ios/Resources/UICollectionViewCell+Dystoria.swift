//
//  UICollectionViewCell+Dystoria.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

extension UICollectionViewCell {
    static func cellIdentifierForType<T: UICollectionViewCell>(type: T.Type) -> String {
        return String(describing: type)
    }
}
