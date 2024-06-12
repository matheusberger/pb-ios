//
//  SongsViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song {
    @MainActor
    public class ListViewModel: ObservableObject {
        
        enum State {
            case empty, content
        }
        
        @Published var isShowingAlert = false
        @Published var searchText: String = ""
        @Published var allSongs: [Song] {
            didSet {
                do {
                    try songProvider.update(allSongs)
                } catch {
                    isShowingAlert = true
                    alert = Alert(title: Text("Saving error"),
                                  message: Text(error.localizedDescription),
                                  dismissButton: .default(Text("OK"), action: {
                        self.isShowingAlert = false
                        self.alert = nil
                    }))
                }
            }
        }
        
        var alert: Alert?
        
        func detailView(_ song: Song) -> DetailView {
            let viewModel = DetailViewModel(song: song, pedalProvider: pedalProvider)
            return DetailView(viewModel: viewModel)
        }
        
        private var songProvider: any DataProviderProtocol<Song>
        private var pedalProvider: any DataProviderProtocol<Pedal>
        
        private var navigationModel: NavigationModel?

        var songs: [Song] {
            if searchText.isEmpty {
                return allSongs
            } else {
                return allSongs.filter {
                    $0.name.localizedCaseInsensitiveContains(searchText) || $0.artist.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        var state: State {
            if allSongs.isEmpty {
                return .empty
            } else {
                return .content
            }
        }
        
        init(songProvider: any DataProviderProtocol<Song>, pedalProvider: any DataProviderProtocol<Pedal>) {
            self.allSongs = []
            self.songProvider = songProvider
            self.pedalProvider = pedalProvider
            load()
        }
        
        private func load() {
            do {
                try songProvider.load { songs in
                    self.allSongs = songs
                }
            } catch {
                isShowingAlert = true
                alert = Alert(title: Text("Loading error"),
                              message: Text(error.localizedDescription),
                              dismissButton: .default(Text("OK"), action: {
                    self.isShowingAlert = false
                    self.alert = nil
                }))
            }
        }
        
        public func setNavigationModel(_ navigationModel: NavigationModel) {
            self.navigationModel = navigationModel
        }
        
        func deleteSong(_ deletedSong: Song) {
            allSongs = allSongs.filter { $0 != deletedSong }
        }
    }
}

/// Navigation
extension Song.ListViewModel {
    func navigateToPedaList() {
        navigationModel?.push(.pedalList)
    }
    
    // EditViewModel for navigation with the navigationModel
    var editViewModel: Song.EditViewModel {
        return Song.EditViewModel(availablePedals: pedalProvider.data) { song in
            self.allSongs.append(song)
            self.navigationModel?.pop()
        }
    }
}
