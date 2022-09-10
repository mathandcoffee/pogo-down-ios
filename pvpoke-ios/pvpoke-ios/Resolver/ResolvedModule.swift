//
//  ResolvedModule.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/7/21.
//

import Foundation
import Resolver

typealias ResolvedModule = Uninitializable & Module

protocol Module: Uninitializable {
    static func register()
}
