//
//  SongsViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song {
    public class ListViewModel: ObservableObject {
        
        enum State {
            case empty, content
        }
        
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
        @Published var isShowingAlert = false
        @Published var isShowingSheet: Bool = false
        @Published var searchText: String = ""
        
        var alert: Alert?
        
        var pedalView: Pedal.ListView {
            let viewModel = Pedal.ListViewModel(provider: pedalProvider)
            return Pedal.ListView(viewModel: viewModel)
        }
        
        var editView: EditView {
            let viewModel = EditViewModel(pedalProvider: pedalProvider, delegate: self)
            return Song.EditView(viewModel: viewModel)
        }
        
        func detailView(_ song: Song) -> DetailView {
            let viewModel = DetailViewModel(song: song, pedalProvider: pedalProvider, delegate: self)
            return DetailView(viewModel: viewModel)
        }
        
        private var songProvider: LocalDataProvider<Song>
        private var pedalProvider: LocalDataProvider<Pedal>
        
        public init() {
            let songPersistence = JsonDataService<Song>(fileName: "Song")
            self.songProvider =  LocalDataProvider<Song>(persistence: songPersistence)
            self.allSongs = []
            
            let pedalPersistence = JsonDataService<Pedal>(fileName: "Pedal")
            self.pedalProvider =  LocalDataProvider<Pedal>(persistence: pedalPersistence)
            
            load()
        }
        
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
        
        init(songProvider: LocalDataProvider<Song>) {
            self.allSongs = []
            self.songProvider = songProvider
            
            let pedalPersistence = JsonDataService<Pedal>(fileName: "Pedal")
            self.pedalProvider =  LocalDataProvider<Pedal>(persistence: pedalPersistence)
            
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
        
        public func addSongPressed() {
            isShowingSheet = true
        }
        
        func deleteSong(_ deletedSong: Song) {
            allSongs = allSongs.filter { $0 != deletedSong }
        }
    }
}

extension Song.ListViewModel: Song.EditDelegate {
    func addSong(_ song: Song) throws {
        try validateSong(song)
        
        self.allSongs.append(song)
        isShowingSheet = false
    }
    
    func updateSong(for updatedSong: Song) throws {
        try validateSong(updatedSong)
        
        allSongs = allSongs.map({ song in
            song == updatedSong ? updatedSong : song
        })
    }
    
    private func validateSong(_ song: Song) throws {
        if song.name.isEmpty {
            throw Song.EditError.missingName
        }
        
        if song.artist.isEmpty {
            throw Song.EditError.missingArtist
        }
    }
}
