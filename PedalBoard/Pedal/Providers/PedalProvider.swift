//
//  PedalProvider.swift
//  PedalBoard
//
//  Created by Matheus Berger on 11/06/24.
//

import Foundation
import PedalCore

final class PedalProvider: DataProviderProtocol {
    public typealias T = Pedal
    
    private let persistence: any PersistenceProtocol<Pedal>
    
    private(set) public var data: [Pedal]
    
    public init(persistence: any PersistenceProtocol<Pedal> = JsonDataService(fileName: "pedal")) {
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
