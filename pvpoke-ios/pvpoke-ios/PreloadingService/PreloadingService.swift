//
//  PreloadingService.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation
import Resolver

protocol PreloadingService {
    func preloadContent()
}

private final class PreloadingServiceImpl: PreloadingService {
    
    func preloadContent() {
        
    }
}

class PreloadingServiceModule: ResolvedModule {
    static func register() {
        Resolver.register { PreloadingServiceImpl() as PreloadingService }.scope(.cached)
    }
}
