//
//  Moves.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 {
     "moveId": "ACID",
     "name": "Acid",
     "abbreviation": "Ac",
     "type": "poison",
     "power": 6,
     "energy": 0,
     "energyGain": 5,
     "cooldown": 1000,
     "archetype": "Low Quality"
 }
 */

struct Move: JSONCodable {
    let moveId: String
    let name: String
    let abbreviation: String?
    let type: PokemonType
    let power: Int
    let energy: Int
    let energyGain: Int
    let cooldown: Int
    let archetype: Archetype?
}
