//
//  TeamBuilderState.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

struct TeamBuilderState: State {
    let createdAt: Date
    let groupNames: [String]
    let moves: [Move]
    let modifyingIndex: Int?
    let team: Team?
    let availablePokemon: [Pokemon]
    let currentlySelectedPokemon: Pokemon?
    
    func getPokemonForCup() -> [Pokemon] {
        let names = team?.cup?.include.first?.values
        return availablePokemon.filter { names?.contains($0.speciesName) ?? false }
    }
}
