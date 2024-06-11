//
//  LocalDataProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 11/06/24.
//

import Foundation

public final class LocalDataProvider<T: Hashable>: DataProviderProtocol {
    public typealias T = T
    
    private let persistence: any PersistenceProtocol<T>
    
    private(set) public var data: [T]
    
    public init(persistence: any PersistenceProtocol<T>) {
        self.persistence = persistence
        self.data = []
    }
    
    public func update(_ newData: [T]) throws {
        self.data = newData
        try persistence.save(data)
    }
    
    public func load(_ onLoad: @escaping ([T]) -> Void) throws {
        try persistence.load { loadedData in
            self.data = loadedData
            onLoad(loadedData)
        }
    }
}
