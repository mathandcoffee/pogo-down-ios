//
//  Team.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import Foundation

struct Team: JSONCodable {
    let id: Int
    let name: String
    let pokemon: [Pokemon]
    let cup: Cup?
}
