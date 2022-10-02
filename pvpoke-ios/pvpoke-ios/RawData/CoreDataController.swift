//
//  CoreDataController.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/29/22.
//

import UIKit
import CoreData
import Resolver

final class CoreDataController {
    
    fileprivate init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        guard let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            fatalError()
        }
        return container
    }()
    
    func saveContext() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func createNewTeam() -> TeamEntity {
        let teamEnitity = TeamEntity(context: persistentContainer.viewContext)
        teamEnitity.id = UUID()
        teamEnitity.pokemon = ""
        saveContext()
        return teamEnitity
    }
    
    func addTeam(pokemon: [Pokemon]) {
        let team = TeamEntity(context: persistentContainer.viewContext)
        guard let data = try? JSONEncoder().encode(pokemon) else { return }
        team.pokemon = String(data: data, encoding: .utf8)
        team.id = UUID()
        saveContext()
    }
    
    func editTeam(team: TeamEntity, pokemon: [Pokemon]) {
        guard let data = try? JSONEncoder().encode(pokemon) else { return }
        team.pokemon = String(data: data, encoding: .utf8)
        saveContext()
    }
    
    func getTeams() -> [TeamEntity] {
        //TODO: Handle this with alerts as needed
        let fetchRequest = NSFetchRequest<TeamEntity>(entityName: String(describing: TeamEntity.self))
        let fetchedData = try? persistentContainer.viewContext.fetch(fetchRequest)
        return fetchedData ?? []
    }
}

final class CoreDataModule: ResolvedModule {
    
    static func register() {
        Resolver.register { CoreDataController() }.scope(.cached)
    }
}

extension TeamEntity {
    
    func pokemonArray() -> [Pokemon] {
        guard let pokemonData = pokemon?.data(using: .utf8) else { return [] }
        return (try? JSONDecoder().decode([Pokemon].self, from: pokemonData)) ?? []
    }
}
