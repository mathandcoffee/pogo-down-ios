//
//  TeamBuilderViewModel.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation
import Resolver

final class TeamBuilderViewModel: BaseViewModel<TeamBuilderState, TeamBuilderEvent> {
    
    @Injected private var dataLoadingService: DataLoadingService
    
    init() {
        super.init(
            initialState: TeamBuilderState(
                createdAt: Date(),
                groupNames: [],
                moves: [],
                modifyingIndex: -1,
                team: nil,
                availablePokemon: [],
                currentlySelectedPokemon: nil
            )
        )
        getData()
    }
    
    private func getData() {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                groupNames: dataLoadingService.groups.map { $0.name },
                moves: dataLoadingService.moves,
                modifyingIndex: -1,
                team: currentState.team,
                availablePokemon: dataLoadingService.pokemon,
                currentlySelectedPokemon: nil
            )
        )
    }
    
    func retrieveTeamWithId(_ id: UUID) {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                groupNames: currentState.groupNames,
                moves: currentState.moves,
                modifyingIndex: -1,
                team: nil,
                availablePokemon: currentState.availablePokemon,
                currentlySelectedPokemon: currentState.currentlySelectedPokemon
            )
        )
    }
    
    func selectPokemonToChange(index: Int) {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                groupNames: currentState.groupNames,
                moves: currentState.moves,
                modifyingIndex: index,
                team: currentState.team,
                availablePokemon: currentState.availablePokemon,
                currentlySelectedPokemon: currentState.currentlySelectedPokemon
            )
        )
    }
    
    func selectPokemon(pokemon: Pokemon) {
        let newState = TeamBuilderState(createdAt: Date(), groupNames: currentState.groupNames, moves: currentState.moves, modifyingIndex: currentState.modifyingIndex, team: currentState.team, availablePokemon: currentState.availablePokemon, currentlySelectedPokemon: pokemon)
        setState(newState)
    }
    
    func changePokemonAtChangePosition(pokemon: Pokemon) {
        guard let modifyingIndex = currentState.modifyingIndex, var team = currentState.team else { return }
        if modifyingIndex >= team.pokemon.count {
            team.pokemon.append(pokemon)
        } else {
            team.pokemon[modifyingIndex] = pokemon
        }
        let newState = TeamBuilderState(createdAt: Date(), groupNames: currentState.groupNames, moves: currentState.moves, modifyingIndex: nil, team: team, availablePokemon: currentState.availablePokemon, currentlySelectedPokemon: currentState.currentlySelectedPokemon)
        setState(newState)
    }
    
    func createNewTeam() {
        setState(TeamBuilderState(createdAt: Date(),  groupNames: currentState.groupNames, moves: currentState.moves, modifyingIndex: currentState.modifyingIndex, team: Team(id: UUID(), name: "", pokemon: [], cup: nil, group: nil), availablePokemon: currentState.availablePokemon, currentlySelectedPokemon: currentState.currentlySelectedPokemon))
    }
    
    func saveTeam() {
        guard let team = currentState.team else { return }
        sendEvent(.teamSaved(team: team))
    }
    
    func filterByString(_ searchString: String?) {
        
    }
}

final class TeamBuilderViewModelModule: ResolvedModule {
    static func register() {
        Resolver.register { TeamBuilderViewModel() }.scope(.shared)
    }
}
