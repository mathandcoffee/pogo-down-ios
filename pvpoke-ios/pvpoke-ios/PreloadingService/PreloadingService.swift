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
    
    var testPokemon: [Pokemon] = []
    var testMoves: [Move] = []
    var testFormats: [Format] = []
    
    func preloadContent() {
        testPokemon = Pokemon.parseFile([Pokemon].self, fileName: "pokemon", subdirectory: "RawData/gamemaster") ?? []
        testMoves = Move.parseFile([Move].self, fileName: "moves", subdirectory: "RawData/gamemaster") ?? []
        testFormats = Format.parseFile([Format].self, fileName: "formats", subdirectory: "RawData/gamemaster") ?? []
        print()
    }
}

class PreloadingServiceModule: ResolvedModule {
    static func register() {
        Resolver.register { PreloadingServiceImpl() as PreloadingService }.scope(.cached)
    }
}
