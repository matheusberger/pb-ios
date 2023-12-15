//
//  PersistenceService.swift
//  PedalCore
//
//  Created by Matheus Berger on 07/12/23.
//

import Foundation

public final class JsonDataService<T: Codable>: PersistenceProtocol where T: Hashable {
    typealias T = T
    
    private let fileUrl: URL?
    
    public init(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fileUrl = nil
            return // throw error instead
        }
        
        fileUrl = documentDirectory.appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
    public func save(_ data: [T]) throws {
        do {
            // convert data to json
            let jsonData = try JSONEncoder().encode(data)
            
            // save json to fileURL
            guard let fileUrl = self.fileUrl else {
                throw ServiceError.noFileUrl("No valid file URL to write to.")
            }
            try jsonData.write(to: fileUrl)
        }
    }
    
    public func load(onLoad: ([T]) -> Void) throws {
        // get fileURL
        guard let fileUrl = self.fileUrl else {
            throw ServiceError.noFileUrl("No valid file URL to read from.")
        }
        
        // load from fileUrl
        let jsonData = try Data(contentsOf: fileUrl)
        let decodedData = try JSONDecoder().decode([T].self, from: jsonData)
        onLoad(decodedData)
    }
    
    enum ServiceError: Error {
        case invalidID(String)
        case failedSerialization(String)
        case noFileUrl(String)
    }
}
