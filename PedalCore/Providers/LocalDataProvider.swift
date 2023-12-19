//
//  LocalDataProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation

class LocalDataProvider<T: Hashable>: DataProviderProtocol {
    typealias T = T
    
    private let persistenceService: any PersistenceProtocol<T>
    
    private(set) var data: [T]
    
    init(persistenceService: any PersistenceProtocol<T>) {
        self.persistenceService = persistenceService
        self.data = []
    }
    
    func update(_ newData: [T]) throws {
        self.data = newData
        try persistenceService.save(data)
    }
    
    func load(_ onLoad: ([T]) -> Void) throws {
        try persistenceService.load { loadedData in
            self.data = loadedData
            onLoad(loadedData)
        }
    }
}
