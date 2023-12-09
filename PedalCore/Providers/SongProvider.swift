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
        self.persistenceService = JsonDataService<Song>(filePath: "")
        do {
            try persistenceService.load { data in
                self.songs = data
            }
        } catch {
            print(error)
        }
    }
    
    func update(_ songs: [Song]) {
        self.songs = songs
        persistenceService.update(songs)
    }
    
    enum PedalProviderErrors: Error {
        case loadingError(String)
    }
}
