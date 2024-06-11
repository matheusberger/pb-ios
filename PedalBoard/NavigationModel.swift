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
    @Published var isPresentingSheet: Bool
    
    private(set) var songProvider: SongProvider
    private(set) var pedalProvider: PedalProvider
    
    var presentedSheets: [AnyView]
    
    init(navigationPath: NavigationPath = .init()) {
        self.navigationPath = navigationPath
        self.isPresentingSheet = false
        self.presentedSheets = []
        
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
    }
    
    func toRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    enum AppView: Hashable, Sendable {
        case songList
        case pedalList
    }
}

/// Sheet presentation
extension NavigationModel {
    func presentSongEditView(delegate: Song.EditDelegate) {
        isPresentingSheet = true
        let viewModel = Song.EditViewModel(pedalProvider: pedalProvider, delegate: delegate)
        let songEditView = Song.EditView(viewModel: viewModel)
        presentedSheets.append(AnyView(songEditView))
    }
    
    func presentPedalEditView(_ pedal: Pedal, delegate: Pedal.EditDelegate) {
        isPresentingSheet = true
        let viewModel = Pedal.EditViewModel(pedal, delegate: delegate)
        let pedalEditView = Pedal.EditView(viewModel: viewModel)
        presentedSheets.append(AnyView(pedalEditView))
    }
    
    func dismissSheet() {
        _ = presentedSheets.popLast()
        isPresentingSheet = presentedSheets.isEmpty ? false : true
    }
}

