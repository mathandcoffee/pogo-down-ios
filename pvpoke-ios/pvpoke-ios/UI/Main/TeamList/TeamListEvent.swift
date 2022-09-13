//
//  TeamListEvent.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import Foundation

enum TeamListEvent: Event {
    case showTeam(teamId: Int)
    case createTeam
}
