//
//  JSONCodable.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/7/21.
//

import Foundation

protocol JSONCodable: Codable  {}

extension JSONCodable {
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
