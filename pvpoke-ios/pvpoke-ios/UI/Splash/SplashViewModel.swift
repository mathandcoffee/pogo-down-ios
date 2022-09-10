//
//  SplashViewModel.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/6/22.
//

import Foundation
import Resolver

final class SplashViewModel: BaseViewModel<SplashState, SplashEvent> {
    
    @Injected private var preloadingService: PreloadingService
    
    init() {
        super.init(initialState: SplashState())
    }
    
    func preloadContent() {
        
    }
}
