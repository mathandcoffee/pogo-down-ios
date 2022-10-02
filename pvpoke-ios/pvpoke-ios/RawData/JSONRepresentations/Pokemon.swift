//
//  Pokemon.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "dex": 1,
 "speciesName": "Bulbasaur",
 "speciesId": "bulbasaur",
 "baseStats": {
     "atk": 118,
     "def": 111,
     "hp": 128
 },
 "types": ["grass", "poison"],
 "fastMoves": ["TACKLE", "VINE_WHIP"],
 "chargedMoves": ["POWER_WHIP", "SEED_BOMB", "SLUDGE_BOMB"],
 "tags": ["starter", "shadoweligible"],
 "defaultIVs": {
     "cp500": [18, 2, 14, 7],
     "cp1500": [50, 15, 15, 15],
     "cp2500": [50, 15, 15, 15]
 },
 "level25CP": 627,
 "buddyDistance": 3,
 "thirdMoveCost": 10000,
 "released": true,
 "family": {
     "id": "FAMILY_BULBASAUR",
     "evolutions": ["ivysaur"]
 }
 */

struct Pokemon: JSONCodable {
    
    let dex: Int
    let speciesName: String
    let speciesId: String
    let baseStats: Stats
    let types: [PokemonType]
    let fastMoves: [String]
    let chargedMoves: [String]
    let defaultIVs: DefaultIVs
    let level25CP: Int?
    let buddyDistance: Int?
    let thirdMoveCost: Int?
    let released: Bool?
    let family: Family?
    var selectedFastMove: Int?
    var selectedChargeMove: [Int]?
}
