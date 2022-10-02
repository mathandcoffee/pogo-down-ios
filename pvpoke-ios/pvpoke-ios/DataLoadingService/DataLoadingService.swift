//
//  PreloadingService.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation
import Resolver

protocol DataLoadingService {
    var base: Base? { get }
    var pokemon: [Pokemon] { get }
    var moves: [Move] { get }
    var formats: [Format] { get }
    var cups: [Cup] { get }
    var groups: [Group] { get }
}

private final class DataLoadingServiceImpl: DataLoadingService {
    
    //TODO: Consider Pushing these to CoreData
    private(set) var base: Base? = nil
    private(set) var pokemon: [Pokemon] = []
    private(set) var moves: [Move] = []
    private(set) var formats: [Format] = []
    private(set) var cups: [Cup] = []
    private(set) var groups: [Group] = []
    private(set) var aiArchetypes: [AIArchetype] = []
    
    init() {
        preloadContent()
    }
    
    private func preloadContent() {
        guard base == nil else { return }
        pokemon = parseFile([Pokemon].self, fileName: "pokemon") ?? []
        moves = parseFile([Move].self, fileName: "moves") ?? []
        formats = parseFile([Format].self, fileName: "formats") ?? []
        base = parseFile(Base.self, fileName: "base")
        cups = parseAllFilesInPath(Cup.self, folderPath: "cups")
        aiArchetypes = parseFile([AIArchetype].self, fileName: "training/aiArchetypes") ?? []
        
        groups = parseGroups()
    }
    
    private func jsonFilePath() -> URL? {
        return Bundle.main.resourceURL?.appendingPathComponent("gamemaster")
    }
    
    private func parseFile<T: Codable>(_ type: T.Type, fileName: String) -> T? {
        if let path = jsonFilePath()?.appendingPathComponent(fileName).appendingPathExtension(for: .json) {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(type, from: data)
                return jsonResult
            } catch {
                fatalError()
            }
        }
        return nil
    }
    
    private func parseGroups() -> [Group] {
        var groups: [Group] = []
        guard let path = jsonFilePath()?.appendingPathComponent("groups") else {
            return groups
        }
        let fileManager = FileManager.default
        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: path.path)
            for file in fileURLs {
                let url = path.appendingPathComponent(file)
                if url.pathExtension != "json" { continue }
                do {
                    let data = try Data(contentsOf: url, options: .mappedIfSafe)
                    //TODO: Remove this force unwrap when testing is done
                    let jsonResult = try JSONDecoder().decode([PokemonGroupListing].self, from: data)
                    groups.append(Group(name: file, pokemonListings: jsonResult))
                } catch {
                    fatalError()
                }
            }
        } catch {
            fatalError()
        }
        return groups
    }
    
    private func parseAllFilesInPath<T: Codable>(
        _ type: T.Type,
        folderPath: String
    ) -> [T] {
        var jsons: [T] = []
        guard let path = jsonFilePath()?.appendingPathComponent(folderPath) else {
            return jsons
        }
        let fileManager = FileManager.default
        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: path.path)
            for file in fileURLs {
                let url = path.appendingPathComponent(file)
                if url.pathExtension != "json" { continue }
                do {
                    let data = try Data(contentsOf: url, options: .mappedIfSafe)
                    //TODO: Remove this force unwrap when testing is done
                    let jsonResult = try JSONDecoder().decode(type, from: data)
                    jsons.append(jsonResult)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        } catch {
            fatalError()
        }
        
        return jsons
    }
}

class DataLoadingServiceModule: ResolvedModule {
    static func register() {
        Resolver.register { DataLoadingServiceImpl() as DataLoadingService }.scope(.cached)
    }
}
