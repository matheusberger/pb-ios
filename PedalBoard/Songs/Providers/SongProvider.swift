//
//  SongProvider.swift
//  PedalBoard
//
//  Created by Matheus Berger on 11/06/24.
//

import Foundation
import PedalCore

final class SongProvider: DataProviderProtocol {
    public typealias T = Song
    
    private let persistence: any PersistenceProtocol<Song>
    
    private(set) public var data: [Song]
    
    public init(persistence: any PersistenceProtocol<Song> = JsonDataService(fileName: "song")) {
        self.persistence = persistence
        self.data = []
    }
    
    public func update(_ newData: [Song]) throws {
        self.data = newData
        try persistence.save(data)
    }
    
    public func load(_ onLoad: @escaping ([Song]) -> Void) throws {
        try persistence.load { loadedData in
            self.data = loadedData
            onLoad(loadedData)
        }
    }
}
