//
//  TrainingAI.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import Foundation

final class TrainingAI {
    
    private let battle: Battle
    private let player: Player
    private let level: Int
    
    private var currentStrategy: Strategy = .DEFAULT
    private var previousStrategy: Strategy = .DEFAULT
    private var scenarios: RankingScenario?
    
    private var turnLastEvaluated = 0
    
    
    init(
        battle: Battle,
        player: Player,
        level: Int
    ) {
        self.battle = battle
        self.player = player
        self.level = level
    }
    
    private func generateOpponentRoster() {
        
    }
    
    private func generateTeam(
        opponentRoster: [PokemonState],
        previousResult: RankingScenario,
        previousTeams: [[PokemonState]]
    ) {
        
    }
    
    private func testPool() {
        
    }
    
    private func calculateAverageRosterPerformance(teamA: [PokemonState], teamB: [PokemonState]) {
        
    }
    
    private func evaluateMatchup(turn: Int, pokemon: PokemonState, opposingPokemon: Pokemon, opponentPlayer: Player) {
        
    }
    
    private func runScenario(type: RankingScenario, pokemon: Pokemon, opposingPokemon: Pokemon) {
        
    }
    
    private func runBulkScenarios() {
        
    }
    
    private func processStrategy(strategy: Strategy) {
        
    }
    
    private func decideAction(turn: Int, pokemon: Pokemon, opposingPokemon: Pokemon) {
        
    }
    
    private func decideSwitch() {
        
    }
    
    private func decideShield(attacker: Pokemon, defender: Pokemon, move: Move) {
        
    }
    
    private func calculatePotentialDamage(attacker: Pokemon, defender: Pokemon, energy: Int, stack: Bool) {
        
    }
}
