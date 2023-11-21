//
//  RepositoryService.swift
//  PedalCore
//
//  Created by Lucas Migge on 21/11/23.
//

import Foundation

class RepositoryService {

    // should we use combine?
    
    private var userPedals: [Pedal] = Pedal.pedalSample()
    private var userSongs: [Song] = Song.getSample()
    
    static var shared: RepositoryService = RepositoryService()
    
}

extension RepositoryService: PedalCoreDataProvider {
    func getUserSongs() -> [Song] {
        return self.userSongs
    }
    
    func getUserPedals() -> [Pedal] {
        return self.userPedals
    }
    
}

typealias PedalCoreDataProvider = SongsDataProvider & PedalDataProvider

protocol SongsDataProvider {
    func getUserSongs() -> [Song]
    
}

protocol PedalDataProvider {
    func getUserPedals() -> [Pedal]
}
