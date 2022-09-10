//
//  SplashViewModel.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/6/22.
//

import Foundation

final class SplashViewModel: BaseViewModel<SplashState, SplashEvent> {
    
    init() {
        super.init(initialState: SplashState())
    }
    
    func preloadContent() {
        
    }
}
