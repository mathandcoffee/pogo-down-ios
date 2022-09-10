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

class CodableUtils {
    private static func jsonFilePath() -> URL? {
        return Bundle.main.resourceURL?.appendingPathComponent("gamemaster")
    }
    
    static func parseFile<T: Codable>(_ type: T.Type, fileName: String) -> T? {
        if let path = jsonFilePath()?.appendingPathComponent(fileName).appendingPathExtension(for: .json) {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                //TODO: Remove this force unwrap when testing is done
                let jsonResult = try! JSONDecoder().decode(type, from: data)
                return jsonResult
            } catch {
                return nil
            }
        }
        return nil
    }
    
    //TODO: Clean this up with safe syntax (no force unwraps)
    static func parseAllFilesInPath<T: Codable>(
        _ type: T.Type,
        folderPath: String
    ) -> [T] {
        var jsons: [T] = []
        guard let path = jsonFilePath()?.appendingPathComponent(folderPath) else {
            return jsons
        }
        let fileManager = FileManager.default
        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: path.path)
            for file in fileURLs {
                let url = path.appendingPathComponent(file)
                if url.pathExtension != "json" { continue }
                do {
                    let data = try! Data(contentsOf: url, options: .mappedIfSafe)
                    //TODO: Remove this force unwrap when testing is done
                    let jsonResult = try! JSONDecoder().decode(type, from: data)
                    jsons.append(jsonResult)
                } catch {
                    continue
                }
            }
        } catch {
            fatalError()
        }
        
        return jsons
    }
}
