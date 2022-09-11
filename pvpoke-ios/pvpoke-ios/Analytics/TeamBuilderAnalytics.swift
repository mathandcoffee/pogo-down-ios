//
//  TeamBuilderAnalytics.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation
import Resolver
import Combine

protocol TeamBuilderAnalytics {
    func runTeamAnalysis(team: [Pokemon]) -> Future<TeamBuilderResults, Never>
}

final class TeamBuilderAnalyticsImpl: TeamBuilderAnalytics {
    
    func runTeamAnalysis(team: [Pokemon]) -> Future<TeamBuilderResults, Never> {
        return Future { promise in
            promise(.success(TeamBuilderResults()))
        }
    }
}
