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
    var body: some Scene {
        WindowGroup {
            let songPersistence = JsonDataService<Song>(fileName: "song")
            let pedalPersistance = JsonDataService<Pedal>(fileName: "pedal")
            let viewModel = Song.ListViewModel(songProvider: SongProvider(persistence: songPersistence), pedalProvider: PedalProvider(persistence: pedalPersistance))
            NavigationStack {
                Song.ListView(viewModel: viewModel)
            }
        }
    }
}


