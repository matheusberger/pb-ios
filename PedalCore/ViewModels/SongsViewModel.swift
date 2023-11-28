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
    
    @Published var isShowingSheet: Bool = false
    @Published var allSongs: [Song]
    @Published public var songs: [Song]
    @Published var searchText: String = "" {
        didSet {
          filterListedSongs()
        }
    }
    
    init(allSongs: [Song] = Song.getSample()) {
        self.allSongs = allSongs
        self.songs = allSongs
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
        allSongs = allSongs.filter({ $0 != deletedSong })
    }
    
    private func filterListedSongs() {
        if searchText.isEmpty {
            songs =  allSongs
        } else {
            songs = allSongs.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.artist.localizedCaseInsensitiveContains(searchText)
            }
        }
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
