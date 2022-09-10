//
//  DefaultIVs.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation


/**
 "cp500": [18, 2, 14, 7],
 "cp1500": [50, 15, 15, 15],
 "cp2500": [50, 15, 15, 15]
 */

struct DefaultIVs: JSONCodable {
    
    let cp500: [Double]?
    let cp1500: [Double]?
    let cp2500: [Double]?
}
