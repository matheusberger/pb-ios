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
    
    @Published var allSongs: [Song] = Song.getSample()
    @Published var isShowingSheet: Bool = false
    
    @Published var searchText: String = ""
    
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
    func addSong(name: String, artist: String, pedals: [Pedal]) {
        let newSong = Song(name: name, artist: artist, pedals: pedals)
        self.allSongs.append(newSong)
        isShowingSheet = false
    }
    
}
