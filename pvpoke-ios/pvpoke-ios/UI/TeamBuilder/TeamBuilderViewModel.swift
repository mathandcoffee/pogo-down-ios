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
    
    private lazy var testTeams: [Team] = [
        Team(id: 0, name: "Basic Team", pokemon: [dataLoadingService.pokemon[0], dataLoadingService.pokemon[1], dataLoadingService.pokemon[2]],
             cup: dataLoadingService.cups.first),
        Team(id: 1, name: "Snuffle", pokemon: [dataLoadingService.pokemon[3], dataLoadingService.pokemon[4], dataLoadingService.pokemon[5]],
             cup: dataLoadingService.cups.first)
    ]
    
    init() {
        super.init(
            initialState: TeamBuilderState(
                createdAt: Date(),
                currentPokemonSelection: [],
                groupNames: [],
                moves: []
            )
        )
        getData()
    }
    
    private func getData() {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                currentPokemonSelection: currentState.currentPokemonSelection,
                groupNames: dataLoadingService.groups.map { $0.name },
                moves: dataLoadingService.moves
            )
        )
    }
    
    func retrieveTeamWithId(_ id: Int) {
        setState(
            TeamBuilderState(
                createdAt: Date(),
                currentPokemonSelection: testTeams.first { $0.id == id }?.pokemon ?? [],
                groupNames: currentState.groupNames,
                moves: currentState.moves
            )
        )
    }
}
