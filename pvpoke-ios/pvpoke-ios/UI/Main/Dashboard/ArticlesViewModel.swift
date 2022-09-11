//
//  DashboardViewModel.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/8/22.
//

import Foundation

final class ArticlesViewModel: BaseViewModel<ArticlesState, ArticlesEvent> {
    
    init() {
        super.init(initialState: ArticlesState(createdAt: Date()))
    }
}
