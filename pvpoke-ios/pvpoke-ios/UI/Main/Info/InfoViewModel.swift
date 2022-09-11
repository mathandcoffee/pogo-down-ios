//
//  InfoViewModel.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

final class InfoViewModel: BaseViewModel<InfoState, InfoEvent> {
    
    init() {
        super.init(initialState: InfoState(createdAt: Date()))
    }
}
