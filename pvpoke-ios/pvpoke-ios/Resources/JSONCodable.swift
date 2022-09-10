//
//  JSONCodable.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/7/21.
//

import Foundation

protocol JSONCodable: Codable  {}

extension JSONCodable {
    func encode() -> Data {
        try! JSONEncoder().encode(self)
    }
    
    static func jsonFilePath() -> URL? {
        return Bundle.main.resourceURL?.appendingPathComponent("gamemaster")
    }
    
    static func parseFile<T: Codable>(_ type: T.Type, fileName: String, subdirectory: String) -> T? {
        if let path = jsonFilePath()?.appendingPathComponent(fileName).appendingPathExtension(for: .json) {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode(type, from: data)
                return jsonResult
              } catch {
                   return nil
              }
        }
        return nil
    }
}
