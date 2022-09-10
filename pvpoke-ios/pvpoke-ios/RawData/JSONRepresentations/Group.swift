//
//  Group.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "speciesId": "articuno",
 "fastMove": "ICE_SHARD",
 "chargedMoves": ["ICY_WIND", "HURRICANE"]
 */

struct PokemonGroupListing: JSONCodable {
    let speciesId: String
    let fastMove: String?
    let chargedMoves: [String]
    let shadowType: String?
}

struct Group: JSONCodable {
    let name: String
    let pokemonListings: [PokemonGroupListing]
}
