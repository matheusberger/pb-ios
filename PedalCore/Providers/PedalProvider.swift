//
//  PedalProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 10/06/24.
//

import Foundation

final public class PedalProvider: DataProviderProtocol {
    public typealias T = Pedal

    private let persistence: any PersistenceProtocol<Pedal>
    
    private(set) public var data: [Pedal]
    
    public init(persistence: any PersistenceProtocol<Pedal>) {
        self.persistence = persistence
        self.data = []
    }
    
    public func update(_ newData: [Pedal]) throws {
        self.data = newData
        try persistence.save(data)
    }
    
    public func load(_ onLoad: @escaping ([Pedal]) -> Void) throws {
        try persistence.load { loadedData in
            self.data = loadedData
            onLoad(loadedData)
        }
    }
}
