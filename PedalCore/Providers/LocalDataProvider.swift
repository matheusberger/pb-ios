//
//  LocalDataProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation

class LocalDataProvider<T: Hashable>: DataProviderProtocol {
    typealias T = T
    
    private let persistence: any PersistenceProtocol<T>
    
    private(set) var data: [T]
    
    init(persistence: any PersistenceProtocol<T>) {
        self.persistence = persistence
        self.data = []
    }
    
    func update(_ newData: [T]) throws {
        self.data = newData
        try persistence.save(data)
    }
    
    func load(_ onLoad: @escaping ([T]) -> Void) throws {
        try persistenceService.load { loadedData in
            self.data = loadedData
            onLoad(loadedData)
        }
    }
}
