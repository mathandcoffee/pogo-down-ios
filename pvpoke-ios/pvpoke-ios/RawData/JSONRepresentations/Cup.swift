//
//  Cup.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation

/**
 "name": "championship",
 "title": "2022 Championship Series",
 "include": [],
 "exclude": [{
     "filterType": "tag",
     "values": ["mega"]
 }]
 */

struct Cup: JSONCodable {
    let name: String
    let title: String
    let include: [CupFilter]
    let exclude: [CupFilter]
    let partySize: Int?
    let levelCap: Int?
}

struct CupFilter: JSONCodable {
    let filterType: String
    let name: String?
    let values: [String]?
    let includeShadows: Bool?
}
