//
//  SongListViewModel.swift.swift
//  PedalCore
//
//  Created by Lucas Migge on 06/10/23.
//

import Foundation

class SongListViewModel: ObservableObject, AddSongDelegate {
    
    enum State {
        case empty, content
    }
    
    @Published private var allSongs: [Song] = []
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
                $0.name.localizedCaseInsensitiveContains(searchText) || $0.band.localizedCaseInsensitiveContains(searchText)
            }
        }
       
    }
    
    func populateSongs() {
        let songsDemo = [
            Song(name: "Paranoid Android",
                 band: "Radiohead",
                 pedals: [
                    Pedal(name: "Shredmaster",
                          brand: "Marshall",
                          knobs: [
                            Knob(parameter: "volume"),
                            Knob(parameter: "gain"),
                            Knob(parameter: "Contuor")
                          ]
                         ),
                    Pedal(name: "Small Stone",
                          brand: "Eletro-Harmonix",
                          knobs: [
                            Knob(parameter: "Speed"),
                            Knob(parameter: "Tone")
                          ]
                         )
                    
                 ]
                ),
            Song(name: "Teddy Picker",
                 band: "Arctic Monkeys",
                 pedals: [
                    Pedal(name: "Proco Rat",
                          brand: "Generic",
                          knobs: [
                            Knob(parameter: "volume"),
                            Knob(parameter: "gain"),
                            Knob(parameter: "Tone")
                          ]
                         )
                 ]
                )
        ]
        
        songsDemo.forEach {
            allSongs.append($0)
        }
    }
    
    func addSong(name: String, artist: String, pedals: [Pedal]) {
        let newSong = Song(name: name, band: artist, pedals: pedals)
        self.allSongs.append(newSong)
        isShowingSheet = false
    }
}


