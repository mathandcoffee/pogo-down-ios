//
//  TeamListState.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import Foundation

struct TeamListState: State {
    let createdAt: Date
    let teams: [Team]
    let moves: [Move]
}
