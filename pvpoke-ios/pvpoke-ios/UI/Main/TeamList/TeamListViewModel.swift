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
    @Injected private var coreDataController: CoreDataController
    
    init() {
        super.init(initialState: TeamListState(createdAt: Date(), teams: [], moves: [], pokemon: []))
    }
    
     func loadTeams() {
        setState(TeamListState(createdAt: Date(), teams:
                                coreDataController.getTeams(), moves: [], pokemon: dataLoadingService.pokemon))
    }
    
    func navigateToTeamAtIndex(_ index: Int) {
        guard let id = currentState.teams[index].id else { return }
        sendEvent(.showTeam(teamId: id))
    }
}
