//
//  Family.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "id": "FAMILY_BULBASAUR",
 "evolutions": ["ivysaur"]
 */

struct Family: JSONCodable {
    
    let id: String
    let evolutions: [String]?
}
