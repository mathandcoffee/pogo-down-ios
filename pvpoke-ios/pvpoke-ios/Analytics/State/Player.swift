//
//  Player.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import Foundation

final class Player {
    
    init(pokemon: [Pokemon]) {
        self.roster = pokemon.map { PokemonState(pokemon: $0) }
    }
    
    var shields = 2
    var switchTimer = 0
    var switchTime = 60000
    var wins = 0
    var priority = true
    let roster: [PokemonState]
    
    func reset() {
        shields = 2
        switchTimer = 0
        roster.forEach {
            $0.reset()
        }
    }
    
    func useShield() -> Bool {
        if shields <= 0 { return false }
        shields -= 1
        return true
    }
    
    var remainingPokemon: Int {
        return roster.filter { $0.hpRemaining > 0 }.count
    }
}
