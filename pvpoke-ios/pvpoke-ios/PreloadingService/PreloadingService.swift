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
    
    //TODO: Consider Pushing these to CoreData so that we only need parse these files once
    private(set) var testPokemon: [Pokemon] = []
    private(set) var testMoves: [Move] = []
    private(set) var testFormats: [Format] = []
    private(set) var testBase: Base? = nil
    private(set) var testCups: [Cup] = []
    
    func preloadContent() {
        testPokemon = CodableUtils.parseFile([Pokemon].self, fileName: "pokemon") ?? []
        testMoves = CodableUtils.parseFile([Move].self, fileName: "moves") ?? []
        testFormats = CodableUtils.parseFile([Format].self, fileName: "formats") ?? []
        testBase = CodableUtils.parseFile(Base.self, fileName: "base")
        testCups = CodableUtils.parseAllFilesInPath(Cup.self, folderPath: "cups")
    }
}

class PreloadingServiceModule: ResolvedModule {
    static func register() {
        Resolver.register { PreloadingServiceImpl() as PreloadingService }.scope(.cached)
    }
}
