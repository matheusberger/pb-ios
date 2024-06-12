//
//  NavigationModel.swift
//  PedalBoard
//
//  Created by Matheus Berger on 10/06/24.
//

import SwiftUI
import PedalCore

@MainActor
final class NavigationModel: ObservableObject {
    @Published var navigationPath: NavigationPath
    
    private(set) var songProvider: SongProvider
    private(set) var pedalProvider: PedalProvider
    
    init(navigationPath: NavigationPath = .init()) {
        self.navigationPath = navigationPath
        
        let songPersistence = JsonDataService<Song>(fileName: "Song")
        self.songProvider = SongProvider(persistence: songPersistence)
        
        let pedalPersistance = JsonDataService<Pedal>(fileName: "Pedal")
        self.pedalProvider = PedalProvider(persistence: pedalPersistance)
        
        do {
            try songProvider.load { _ in }
            try pedalProvider.load { _ in }
        } catch {
            print("error initializing providers")
        }
    }
    
    func push(_ view: AppView) {
        navigationPath.append(view)
    }
    
    func pop(_ count: Int = 1) {
        guard count < navigationPath.count else {
            return toRoot()
        }
        navigationPath.removeLast(count)
    }
    
    func toRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    enum AppView: Hashable, Sendable {
        case songList
        case pedalList
    }
}
