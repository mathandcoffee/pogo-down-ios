//
//  TeamListViewModel.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import Foundation
import Resolver

final class TeamListViewModel: BaseViewModel<TeamListState, TeamListEvent> {
    
    @Injected private var dataLoadingService: DataLoadingService
    
    init() {
        super.init(initialState: TeamListState(createdAt: Date(), teams: [], moves: []))
        loadInitialState()
    }
    
     func loadInitialState() {
        let testTeams = [
            Team(id: 0, name: "Basic Team", pokemon: [dataLoadingService.pokemon[0], dataLoadingService.pokemon[1], dataLoadingService.pokemon[2]],
                 cup: dataLoadingService.cups.first),
            Team(id: 1, name: "Snuffle", pokemon: [dataLoadingService.pokemon[3], dataLoadingService.pokemon[4], dataLoadingService.pokemon[5]],
                 cup: dataLoadingService.cups.first)
        ]
        setState(TeamListState(createdAt: Date(), teams: testTeams, moves: []))
    }
    
    func navigateToTeamAtIndex(_ index: Int) {
        sendEvent(.showTeam(teamId: currentState.teams[index].id))
    }
}
