//
//  PedalBoardApp.swift
//  PedalBoard
//
//  Created by Migge on 22/08/23.
//

import SwiftUI
import PedalCore

@main
struct PedalBoardApp: App {
    @StateObject private var navigationModel: NavigationModel
    
    private var songProvider: SongProvider
    private var pedalProvider: PedalProvider
    
    init() {
        self._navigationModel = StateObject(wrappedValue: NavigationModel())
        
        let songPersistence = JsonDataService<Song>(fileName: "song")
        self.songProvider = SongProvider(persistence: songPersistence)
        
        let pedalPersistance = JsonDataService<Pedal>(fileName: "pedal")
        self.pedalProvider = PedalProvider(persistence: pedalPersistance)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationModel.navigationPath) {
                let viewModel = Song.ListViewModel(songProvider: songProvider, pedalProvider: pedalProvider)
                
                Song.ListView(viewModel: viewModel)
            }
            .environmentObject(navigationModel)
            .navigationDestination(for: NavigationModel.AppView.self) { view in
                switch view {
                case .songList:
                    let viewModel = Song.ListViewModel(songProvider: songProvider, pedalProvider: pedalProvider)
                    Song.ListView(viewModel: viewModel)
                case.pedalList:
                    let viewModel = Pedal.ListViewModel(provider: pedalProvider)
                    Pedal.ListView(viewModel: viewModel)
                }
            }
            .navigationDestination(for: Pedal.self) { pedal in
                let viewModel = Pedal.EditViewModel()
                Pedal.EditView(viewModel: viewModel)
            }
            .navigationDestination(for: Song.self) { song in
                let viewModel = Song.DetailViewModel(song: song, pedalProvider: pedalProvider)
                Song.DetailView(viewModel: viewModel)
            }
        }
    }
}


