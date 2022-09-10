//
//  Stats.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "atk": 118,
 "def": 111,
 "hp": 128
 */

struct Stats: JSONCodable {
    let atk: Int
    let def: Int
    let hp: Int
}
