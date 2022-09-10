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
                currentPokemonSelection: []
            )
        )
    }
    
    
}
