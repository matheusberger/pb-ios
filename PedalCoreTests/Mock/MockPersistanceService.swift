//
//  MockPersistanceService.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation
import PedalCore

class MockPersistanceService<T: Codable>: PersistenceProtocol where T: Hashable {
    
    private var shouldThrowSaving: Bool
    private var shouldThrowLoading: Bool
    
    private var service: JsonDataService<T>
    
    init(fileName: String, shouldThrowSaving: Bool = false, shouldThrowLoading: Bool = false) {
        self.shouldThrowSaving = shouldThrowSaving
        self.shouldThrowLoading = shouldThrowLoading
        self.service = JsonDataService<T>(fileName: fileName)
    }
    
    func save(_ data: [T]) throws {
        if shouldThrowSaving {
            throw MockedError.failedSave("Error saving data")
        }
        
        try service.save(data)
    }
    
    func load(_ onLoad: @escaping ([T]) -> Void) throws {
        if shouldThrowLoading {
            throw MockedError.failedLoad("Error loading data")
        }
        
        try service.load { data in
            onLoad(data)
        }
    }
    
    enum MockedError: Error {
        case failedSave(String)
        case failedLoad(String)
    }
}
