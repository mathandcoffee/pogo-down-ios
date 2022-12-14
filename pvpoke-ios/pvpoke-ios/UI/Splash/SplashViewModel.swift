//
//  SplashViewModel.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/6/22.
//

import Foundation
import Resolver

final class SplashViewModel: BaseViewModel<SplashState, SplashEvent> {
    
    @Injected private var dataLoadingService: DataLoadingService
    
    init() {
        super.init(initialState: SplashState())
    }
    
    func preloadContent() {
        //TODO: Handle CoreData loading here potentially
        sendEvent(.finishedPreloading())
    }
}
