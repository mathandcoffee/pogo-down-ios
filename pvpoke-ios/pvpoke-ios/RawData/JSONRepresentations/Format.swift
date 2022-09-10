//
//  Format.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "title": "Master League (Classic)",
 "cup": "classic",
 "cp": 10000,
 "meta": "master",
 "showCup": false,
 "showFormat": true,
 "showMeta": false,
 "hideRankings": true
 */

struct Format: JSONCodable {
    let title: String
    let cup: String
    let cp: Int
    let meta: String
    let showCup: Bool
    let showFormat: Bool
    let showMeta: Bool
    let hideRankings: Bool?
}
