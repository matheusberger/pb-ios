//
//  PersistenceService.swift
//  PedalCore
//
//  Created by Matheus Berger on 07/12/23.
//

import Foundation
import CoreData

final class JsonDataService<T>: PersistenceProtocol where T: Identifiable {
    typealias T = T
    private var data: [T]
    
    private let fileUrl: URL
    
    init(filePath: String) {
        fileUrl = URL(fileURLWithPath: filePath)
        data = []
        do {
            try self.load { loadedData in
                data = loadedData
            }
        } catch {
            print("Error loading initial values: \(error)")
        }
    }
    
    func save() throws {
        // Save self.data to filePath
    }
    
    func load(onLoad: ([T]) -> Void) throws {
        // load from fileUrl
        let loadedData = [T]()
        onLoad(loadedData)
    }
    
    func update(_ data: [T]) {
        self.data = data
    }
}

extension JsonDataService {
    enum ServiceError: Error {
        case invalidID(String)
    }
}
