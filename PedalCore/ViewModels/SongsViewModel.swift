//
//  SongsViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

class SongsViewModel: ObservableObject {
    
    enum State {
        case empty, content
    }
    
    @Published var allSongs: [Song]
    @Published var isShowingSheet: Bool = false
    
    @Published var searchText: String = ""
    
    init(allSongs: [Song] = Song.getSample()) {
        self.allSongs = allSongs
    }
    
    
    public var state: State {
        if allSongs.isEmpty {
            return .empty
        } else {
            return .content
        }
    }
    
    public var songs: [Song] {
        if searchText.isEmpty {
            allSongs
        } else {
            allSongs.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.artist.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    
    public func addSongPressed() {
        isShowingSheet = true
    }
    
    func deleteSong(_ deletedSong: Song) {
        allSongs = allSongs.filter({ $0 != deletedSong })
    }
    
    func populateSongs() {
        let songsDemo = Song.getSample()
        
        songsDemo.forEach {
            allSongs.append($0)
        }
    }
    
}

extension SongsViewModel: AddSongDelegate {
    func addSong(_ song: Song) throws {
        try validateSong(song)
        
        self.allSongs.append(song)
        isShowingSheet = false
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
