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
        teamEnitity.pokemon = []
        saveContext()
        return teamEnitity
    }
    
    func addTeam(pokemon: [PokemonEntity]) {
        let team = TeamEntity(context: persistentContainer.viewContext)
        team.pokemon = pokemon
        team.id = UUID()
        saveContext()
    }
    
    func editTeam(team: TeamEntity, pokemon: [PokemonEntity]) {
        team.pokemon = pokemon
        saveContext()
    }
    
    func getTeams() -> [TeamEntity] {
        //TODO: Handle this with alerts as needed
        let fetchRequest = NSFetchRequest<TeamEntity>(entityName: String(describing: TeamEntity.self))
        let fetchedData = try? persistentContainer.viewContext.fetch(fetchRequest)
        return fetchedData ?? []
    }
    
    func addPokemon(
        atkIv: Int,
        defIv: Int,
        hpIv: Int,
        fastMove: String,
        name: String,
        strongMoveOne: String,
        strongMoveTwo: String
    ) -> PokemonEntity {
        let pokemon = PokemonEntity(context: persistentContainer.viewContext)
        pokemon.id = UUID()
        pokemon.atkIv = Int16(atkIv)
        pokemon.defIv = Int16(defIv)
        pokemon.hpIv = Int16(hpIv)
        pokemon.fastMove = fastMove
        pokemon.strongMoveOne = strongMoveOne
        pokemon.strongMoveTwo = strongMoveTwo
        pokemon.name = name
        saveContext()
        return pokemon
    }
    
    func editPokemon(
        pokemon: PokemonEntity,
        atkIv: Int,
        defIv: Int,
        hpIv: Int,
        fastMove: String,
        name: String,
        strongMoveOne: String,
        strongMoveTwo: String
    ) {
        pokemon.atkIv = Int16(atkIv)
        pokemon.defIv = Int16(defIv)
        pokemon.hpIv = Int16(hpIv)
        pokemon.fastMove = fastMove
        pokemon.strongMoveOne = strongMoveOne
        pokemon.strongMoveTwo = strongMoveTwo
        pokemon.name = name
        saveContext()
    }
}

final class CoreDataModule: ResolvedModule {
    
    static func register() {
        Resolver.register { CoreDataController() }.scope(.cached)
    }
}
