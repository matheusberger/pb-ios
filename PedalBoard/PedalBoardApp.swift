//
//  PedalBoardApp.swift
//  PedalBoard
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

@main
struct PedalBoardApp: App {
    @StateObject private var navigationModel: NavigationModel
    
    private var songProvider: SongProvider {
        navigationModel.songProvider
    }
    
    private var pedalProvider: PedalProvider {
        navigationModel.pedalProvider
    }
    
    init() {
        self._navigationModel = StateObject(wrappedValue: NavigationModel())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationModel.navigationPath) {
                let viewModel = Song.ListViewModel(songProvider: songProvider, pedalProvider: pedalProvider)
                
                Song.ListView(viewModel: viewModel)
                    .sheet(isPresented: $navigationModel.isPresentingSheet) {
                        navigationModel.presentedSheets.last
                    }
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
                    .navigationDestination(for: Song.self) { song in
                        let viewModel = Song.DetailViewModel(song: song, pedalProvider: pedalProvider)
                        Song.DetailView(viewModel: viewModel)
                    }
            }
            .environmentObject(navigationModel)
        }
    }
}


