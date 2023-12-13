//
//  SongsViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

class SongsListViewModel: ObservableObject {
    
    enum State {
        case empty, content
    }
    
    @Published var allSongs: [Song] {
        didSet {
            do {
                try SongProvider.shared.update(allSongs)
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
    
    init() {
        allSongs = []
        do {
            try SongProvider.shared.load { songs in
                allSongs = songs
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
    
    public var songs: [Song] {
        if searchText.isEmpty {
            return allSongs
        } else {
            return allSongs.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.artist.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    public var state: State {
        if allSongs.isEmpty {
            return .empty
        } else {
            return .content
        }
    }
    
    public func addSongPressed() {
        isShowingSheet = true
    }
    
    func deleteSong(_ deletedSong: Song) {
        allSongs = allSongs.filter { $0 != deletedSong }
    }
    
    func populateSongs() {
        let songsDemo = Song.getSample()
        
        songsDemo.forEach {
            allSongs.append($0)
        }
    }
}

extension SongsListViewModel: AddSongDelegate {
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
            throw AddSongError.missingName
        }
        
        if song.artist.isEmpty {
            throw AddSongError.missingArtist
        }
    }
}
