//
//  SongProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 08/12/23.
//

import Foundation

class SongProvider {
    static let shared = SongProvider()
    private let persistenceService: any PersistenceProtocol<Song>
    
    private(set) var songs: [Song] = []
    
    init() {
        self.persistenceService = JsonDataService<Song>(fileName: "Songs")
    }
    
    func update(_ songs: [Song]) throws {
        self.songs = songs
        try persistenceService.save(songs)
    }
    
    func load(onLoad: ([Song]) -> Void) throws {
        try persistenceService.load { data in
            self.songs = data
            onLoad(data)
        }
    }
    
    enum SongProviderErrors: Error {
        case loadingError(String)
    }
}
