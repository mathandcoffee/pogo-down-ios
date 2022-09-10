//
//  Uninitializable.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/7/21.
//

import Foundation

class Uninitializable {
    init() {
        fatalError("You cannot initialize this class")
    }
}
