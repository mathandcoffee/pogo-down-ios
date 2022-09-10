//
//  ResolvedModule.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/7/21.
//

import Foundation
import Resolver

protocol ResolvedModule: Uninitializable {
    static func register()
}
