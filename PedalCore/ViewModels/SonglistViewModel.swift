//
//  SonglistViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 06/10/23.
//

import Foundation

class SonglistViewModel: ObservableObject, AddSongDelegate {
    
    @Published var allSongs: [Song] = []
    @Published var isShowingSheet: Bool = false
    
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


