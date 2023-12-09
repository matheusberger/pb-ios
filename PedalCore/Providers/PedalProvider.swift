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
    
    private var pedals: [Pedal] = [] {
        didSet {
            persistenceService.update(pedals)
        }
    }
    
    init() {
        self.persistenceService = JsonDataService<Pedal>(filePath: "")
        do {
            try persistenceService.load { data in
                self.pedals = data
            }
        } catch {
            print(error)
        }
    }
    
    func addPedal(_ pedal: Pedal) {
        pedals.append(pedal)
    }
    
    func updatePedal(_ pedal: Pedal) {
        pedals = pedals.map {
            $0.id == pedal.id ? pedal : $0
        }
    }
    
    func delete(_ pedal: Pedal) {
        pedals = pedals.filter {
            $0.id != pedal.id
        }
    }
    
    enum PedalProviderErrors: Error {
        case loadingError(String)
    }
}
