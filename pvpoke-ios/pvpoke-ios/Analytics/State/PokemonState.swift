//
//  PokemonState.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import Foundation

final class PokemonState {
    
    let pokemon: Pokemon
    var hpRemaining: Int
    var energy = 0
    var atkModifier = 0
    var defModifier = 0
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        hpRemaining = pokemon.baseStats.hp
    }
    
    func reset() {
        hpRemaining = pokemon.baseStats.hp
        energy = 0
        resetBattleStats()
    }
    
    func resetBattleStats() {
        atkModifier = 0
        defModifier = 0
    }
}
