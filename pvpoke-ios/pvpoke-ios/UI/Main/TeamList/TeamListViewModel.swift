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
        setState(TeamListState(createdAt: Date(), teams: [
        Team(id: UUID(), name: "Anal Fissure", pokemon: [
            dataLoadingService.pokemon.first(where: { $0.speciesName == "Rhyperior"})!,
            dataLoadingService.pokemon.first(where: { $0.speciesName == "Rhyperior"})!,
            dataLoadingService.pokemon.first(where: { $0.speciesName == "Rhyperior"})!
        ], cup: dataLoadingService.cups.first!, group: dataLoadingService.groups.first!)], moves: []))
    }
    
    func navigateToTeamAtIndex(_ index: Int) {
        sendEvent(.showTeam(teamId: currentState.teams[index].id))
    }
}
