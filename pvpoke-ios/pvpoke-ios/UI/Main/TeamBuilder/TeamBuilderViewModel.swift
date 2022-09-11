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
                currentPokemonSelection: [],
                groupNames: []
            )
        )
        getGroups()
    }
    
    private func getGroups() {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                currentPokemonSelection: currentState.currentPokemonSelection,
                groupNames: dataLoadingService.groups.map { $0.name }
            )
        )
    }
    
    func selectGroup(groupIndex: Int) {
        let groupSelection = Set(dataLoadingService.groups[groupIndex].pokemonListings.map { $0.speciesId })
        var pokemonSelection: [Pokemon] = []
        for pokemon in dataLoadingService.pokemon {
            if groupSelection.contains(pokemon.speciesId) {
                pokemonSelection.append(pokemon)
            }
        }
        setState(
            TeamBuilderState(
                createdAt: Date(),
                currentPokemonSelection: pokemonSelection,
                groupNames: currentState.groupNames
            )
        )
    }
}
