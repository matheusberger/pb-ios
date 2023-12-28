//
//  MockPersistanceService.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation
import PedalCore

class MockPersistanceService<T>: PersistenceProtocol where T: Hashable {
    
    private var shouldThrowSaving: Bool
    private var shouldThrowLoading: Bool
    
    init(shouldThrowSaving: Bool, shouldThrowLoading: Bool) {
        self.shouldThrowSaving = shouldThrowSaving
        self.shouldThrowLoading = shouldThrowLoading
    }
    
    func save(_: [T]) throws {
        if shouldThrowSaving {
            throw MockedError.failedSave("Error saving data")
        }
        
        return
    }
    
    func load(_ onLoad: ([T]) -> Void) throws {
        if shouldThrowLoading {
            throw MockedError.failedLoad("Error loading data")
        }
        
        onLoad([])
    }
    
    enum MockedError: Error {
        case failedSave(String)
        case failedLoad(String)
    }
}
