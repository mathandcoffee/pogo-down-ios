//
//  TeamBuilderState.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

struct TeamBuilderState: State {
    let createdAt: Date
    let groupNames: [String]
    let moves: [Move]
    let modifyingIndex: Int?
    let team: TeamEntity?
    let availablePokemon: [Pokemon]
    let currentlySelectedPokemon: Pokemon?
}
