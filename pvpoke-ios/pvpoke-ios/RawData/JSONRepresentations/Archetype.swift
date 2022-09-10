//
//  Archetype.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

enum Archetype: String, JSONCodable {
    case general = "General"
    case lowQuality = "Low Quality"
    case debuff = "Debuff"
    case boostNuke = "Boost Nuke"
    case nuke = "Nuke"
    case selfDebuff = "Self-Debuff"
    case selfDebuffNuke = "Self-Debuff Nuke"
    case selfDebuffSpam = "Self-Debuff Spam"
    case debuffNuke = "Debuff Nuke"
    case boost = "Boost"
    case multipurpose = "Multipurpose"
    case highEnergy = "High Energy"
    case highEnergyDebuff = "High Energy Debuff"
    case fastCharge = "Fast Charge"
    case spamBait = "Spam/Bait"
    case heavyDamage = "Heavy Damage"
    case debuffSpamBait = "Debuff Spam/Bait"
    case boostSpamBait = "Boost Spam/Bait"
}
