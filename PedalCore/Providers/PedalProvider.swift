//
//  PedalProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 07/12/23.
//

import Foundation

class PedalProvider {
    static let shared = PedalProvider()
    private let persistenceService: any PersistenceProtocol<Pedal>
    
    private(set) var pedals: [Pedal] = []
    
    init() {
        self.persistenceService = JsonDataService<Pedal>(fileName: "Pedals")
    }
    
    func update(_ pedals: [Pedal]) throws {
        self.pedals = pedals
        try persistenceService.save(pedals)
    }
    
    func load(onLoad: ([Pedal]) -> Void) throws {
        try persistenceService.load { data in
            self.pedals = data
            onLoad(data)
        }
    }
    
    enum PedalProviderErrors: Error {
        case loadingError(String)
    }
}
