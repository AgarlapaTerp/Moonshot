//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by user256510 on 3/24/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file : String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load file from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode the file from bundle")
        }
        
        return loaded
    }
}


extension FileManager {
    func decode<T: Codable>(_ file: String) throws -> T {
        let path = URL.documentsDirectory.appending(path: file)
        
        let data = try Data(contentsOf: path)
        let obj = try JSONDecoder().decode(T.self, from: data)
            
        return obj
    }
}
