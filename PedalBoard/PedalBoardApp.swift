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
            let viewModel = Song.ListViewModel()
            NavigationStack {
                Song.ListView(viewModel: viewModel)
            }
        }
    }
}


