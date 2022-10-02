//
//  AIArchetype.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import Foundation

struct AIArchetype: JSONCodable {
    
    let name: String
    let level: Int
    let chargedMoveCount: Int
    let energyGuessRange: Int
    let moveGuessCertainty: Int
    let reactionTime: Int
    let ivComboRange: Int
    let strategies: [Strategy]
}

enum Strategy: String, Codable {
    case DEFAULT
    case SHIELD
    case SWITCH_BASIC
    case SWITCH_FARM
    case SWITCH_ADVANCED
    case FARM_ENERGY
    case OVERFARM
    case BAIT_SHIELDS
    case WAIT_CLOCK
    case OPTIMIZE_TIMING
    case PRESERVE_SWITCH_ADVANTAGE
    case ADVANCED_SHIELDING
    case BAD_DECISION_PROTECTION
    case SACRIFICIAL_SWAP
}
