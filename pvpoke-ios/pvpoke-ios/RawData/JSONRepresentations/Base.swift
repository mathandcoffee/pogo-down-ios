//
//  Base.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "settings": {
     "partySize": 3,
     "maxBuffStages": 4,
     "buffDivisor": 4,
     "shadowAtkMult": 1.2,
     "shadowDefMult": 0.83333331
 },
 "rankingScenarios": [{
     "slug": "leads",
     "shields": [1, 1],
     "energy": [0, 0]
 }, {
     "slug": "closers",
     "shields": [0, 0],
     "energy": [0, 0]
 }, {
     "slug": "switches",
     "shields": [1, 1],
     "energy": [4, 0]
 }, {
     "slug": "chargers",
     "shields": [1, 1],
     "energy": [6, 0]
 }, {
     "slug": "attackers",
     "shields": [0, 1],
     "energy": [0, 0]
 }],
 "cups": [],
 "formats": [],
 "pokemonTags": ["legendary", "mythical", "alolan", "galarian", "starter", "regional", "shadow", "shadoweligible", "untradeable", "mega", "xs", "hisuian"],
 "pokemonTraits": {
     "pros": ["bulky", "extremely bulky", "spammy", "agile", "flexible", "dynamic", "fast move pressure", "shield pressure", "defensive", "momentum"],
     "cons": ["less bulky", "glass cannon", "slow", "clumsy", "inflexible", "low fast move pressure", "low shield pressure", "vulnerable", "volatile", "chaotic", "technical", "inconsistent"]
 },
 "pokemonRegions": [{
     "string": "gen1",
     "name": "kanto",
     "dexStart": 1,
     "dexEnd": 151
 }, {
     "string": "gen2",
     "name": "johto",
     "dexStart": 152,
     "dexEnd": 251
 }, {
     "string": "gen3",
     "name": "hoenn",
     "dexStart": 252,
     "dexEnd": 386
 }, {
     "string": "gen4",
     "name": "sinnoh",
     "dexStart": 387,
     "dexEnd": 493
 }, {
     "string": "gen5",
     "name": "unova",
     "dexStart": 494,
     "dexEnd": 649
 }, {
     "string": "gen6",
     "name": "kalos",
     "dexStart": 650,
     "dexEnd": 721
 }, {
     "string": "gen7",
     "name": "alola",
     "dexStart": 722,
     "dexEnd": 807
 }, {
     "string": "gen8",
     "name": "galar",
     "dexStart": 808,
     "dexEnd": 898
 }],
 "shadowPokemon": ["bulbasaur", "ivysaur", "venusaur", "venusaur_mega", "charmander", "charmeleon", "charizard", "charizard_mega_x", "charizard_mega_y", "squirtle", "wartortle", "blastoise", "weedle", "kakuna", "beedrill", "beedrill_mega", "rattata", "raticate", "zubat", "golbat", "oddish", "gloom", "vileplume", "venonat", "venomoth", "meowth", "persian", "psyduck", "golduck", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "alakazam_mega", "grimer", "muk", "drowzee", "hypno", "cubone", "marowak", "hitmonchan", "scyther", "electabuzz", "magmar", "magikarp", "gyarados", "gyarados_mega", "lapras", "snorlax", "dratini", "dragonair", "dragonite", "crobat", "mareep", "flaaffy", "ampharos", "ampharos_mega", "bellossom", "politoed", "scizor", "scizor_mega", "houndour", "houndoom", "houndoom_mega", "larvitar", "pupitar", "tyranitar", "tyranitar_mega", "mudkip", "marshtomp", "swampert", "swampert_mega", "seedot", "nuzleaf", "shiftry", "ralts", "kirlia", "gardevoir", "gardevoir_mega", "trapinch", "vibrava", "flygon", "shuppet", "banette", "banette_mega", "duskull", "dusclops", "turtwig", "grotle", "torterra", "electivire", "magmortar", "gallade", "gallade_mega", "dusknoir", "magnemite", "magneton", "magnezone", "bellsprout", "weepinbell", "victreebel", "sandshrew", "sandslash", "porygon", "porygon2", "porygon_z", "wobbuffet", "meowth", "persian", "hitmonlee", "articuno", "sneasel", "weavile", "sableye", "sableye_mega", "zapdos", "moltres", "delibird", "stantler", "absol", "bagon", "shelgon", "salamence", "salamence_mega", "snover", "abomasnow", "abomasnow_mega", "raikou", "vulpix", "ninetales", "exeggcute", "exeggutor", "omanyte", "omastar", "misdreavus", "mismagius", "carvanha", "sharpedo", "sharpedo_mega", "pinsir", "pinsir_mega", "mawile", "mawile_mega", "beldum", "metang", "metagross", "metagross_mega", "entei", "ekans", "arbok", "koffing", "weezing", "nidoran_female", "nidorina", "nidoran_male", "nidorino", "nidoqueen", "nidoking", "machop", "machoke", "machamp", "gligar", "gliscor", "shuckle", "stunky", "skuntank", "suicune", "pineco", "forretress", "mewtwo", "mewtwo_mega_x", "mewtwo_mega_y", "diglett", "dugtrio", "shellder", "cloyster", "slowpoke", "slowbro", "slowking", "aerodactyl", "skarmory", "teddiursa", "ursaring", "hoppip", "skiploom", "jumpluff", "wooper", "quagsire", "swinub", "piloswine", "mamoswine", "nosepass", "probopass", "aron", "lairon", "aggron", "spheal", "sealeo", "walrein", "lileep", "cradily", "anorith", "armaldo", "aipom", "ambipom", "skorupi", "drapion", "poochyena", "mightyena", "murkrow", "honchkrow", "electrike", "manectric", "snubbull", "granbull", "makuhita", "hariyama", "starly", "staravia", "staraptor", "tangela", "tangrowth", "horsea", "seadra", "kingdra", "ho_oh", "bidoof", "bibarel", "cacnea", "cacturne", "lugia", "voltorb", "electrode", "chikorita", "bayleef", "meganium", "cyndaquil", "quilava", "typhlosion", "totodile", "croconaw", "feraligatr", "whismur", "loudred", "exploud", "hippopotas", "hippowdon", "rattata_alolan", "raticate_alolan", "sandshrew_alolan", "sandslash_alolan", "exeggutor_alolan", "sudowoodo", "girafarig", "numel", "camerupt", "latias", "exeggutor_alolan", "marowak_alolan", "geodude", "graveler", "golem", "shinx", "luxio", "luxray", "purrloin", "liepard", "latios", "foongus", "amoonguss", "patrat", "watchog", "ducklett", "swanna"],
 "pokemon": [],
 "moves": []
 */

struct Base: JSONCodable {
    let settings: BaseSettings
    let rankingScenarios: [RankingScenario]
    let cups: [String]
    let formats: [String]
    let pokemonTags: [String]
    let pokemonTraits: PokemonTraits
    let pokemonRegions: [PokemonRegion]
    let shadowPokemon: [String]
    let pokemon: [String]
    let moves: [String]
}

/**
 "settings": {
     "partySize": 3,
     "maxBuffStages": 4,
     "buffDivisor": 4,
     "shadowAtkMult": 1.2,
     "shadowDefMult": 0.83333331
 },
 */

struct BaseSettings: JSONCodable {
    let partySize: Int
    let maxBuffStages: Int
    let buffDivisor: Double
    let shadowAtkMult: Double
    let shadowDefMult: Double
}

/**
 "slug": "leads",
 "shields": [1, 1],
 "energy": [0, 0]
 */

struct RankingScenario: JSONCodable {
    let slug: String
    let shields: [Int]
    let energy: [Int]
}

/**
 "string": "gen4",
 "name": "sinnoh",
 "dexStart": 387,
 "dexEnd": 493
 */

struct PokemonRegion: JSONCodable {
    
    let string: String
    let name: String
    let dexStart: Int
    let dexEnd: Int
}

struct PokemonTraits: JSONCodable {
    let pros: [String]
    let cons: [String]
}
