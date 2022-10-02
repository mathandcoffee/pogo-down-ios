//
//  Traits.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import Foundation

struct Traits {
    
    let weaknesses: [PokemonType]
    let resistances: [PokemonType]
    let immunities: [PokemonType]
    
    static func traitsForType(_ type: PokemonType) -> Traits {
        
        switch(type) {
        case .none:
            return Traits(weaknesses: [], resistances: [], immunities: [])
        case .normal:
            return Traits(weaknesses: [.fighting], resistances: [], immunities: [.ghost])
        case .fighting:
            return Traits(weaknesses: [.flying, .psychic, .fairy], resistances: [.dark, .bug, .rock], immunities: [])
        case .flying:
            return Traits(weaknesses: [.electric, .rock, .ice], resistances: [.fighting, .grass, .bug], immunities: [.ground])
        case .poison:
            return Traits(weaknesses: [.psychic, .ground], resistances: [.fairy, .fighting, .bug, .grass, .poison], immunities: [])
        case .ground:
            return Traits(weaknesses: [.water, .grass, .ice], resistances: [.poison, .rock], immunities: [.electric])
        case .rock:
            return Traits(weaknesses: [.fighting, .ground, .steel, .water, .grass], resistances: [.normal, .flying, .poison, .fire], immunities: [])
        case .bug:
            return Traits(weaknesses: [.flying, .rock, .fire], resistances: [.fighting, .ground, .grass], immunities: [])
        case .ghost:
            return Traits(weaknesses: [.dark, .ghost], resistances: [.poison, .bug], immunities: [.normal, .fighting])
        case .steel:
            return Traits(weaknesses: [.fire, .ground, .fighting], resistances: [.normal, .flying, .rock, .bug, .steel, .grass, .psychic, .ice, .dragon, .fairy], immunities: [.poison])
        case .fire:
            return Traits(weaknesses: [.water, .ground, .rock], resistances: [.fairy, .grass, .steel, .bug, .ice, .fire], immunities: [])
        case .water:
            return Traits(weaknesses: [.electric, .grass], resistances: [.fire, .steel, .water, .ice], immunities: [])
        case .grass:
            return Traits(weaknesses: [.flying, .poison, .bug, .fire, .ice], resistances: [.grass, .ground, .electric, .water], immunities: [])
        case .electric:
            return Traits(weaknesses: [.ground], resistances: [.steel, .electric, .flying], immunities: [])
        case .psychic:
            return Traits(weaknesses: [.bug, .ghost, .dark], resistances: [.fighting, .psychic], immunities: [])
        case .ice:
            return Traits(weaknesses: [.fighting, .fire, .rock, .steel], resistances: [.ice], immunities: [])
        case .dragon:
            return Traits(weaknesses: [.dragon, .ice, .fairy], resistances: [.fire, .water, .grass, .electric], immunities: [])
        case .dark:
            return Traits(weaknesses: [.fighting, .fairy, .bug], resistances: [.ghost, .dark], immunities: [.psychic])
        case .fairy:
            return Traits(weaknesses: [.steel, .poison], resistances: [.fighting, .bug, .dark], immunities: [.dragon])
        }
    }
}
