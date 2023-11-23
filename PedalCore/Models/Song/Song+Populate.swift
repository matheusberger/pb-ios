//
//  Song+Populate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

extension Song {
    static func getSample() -> [Song] {
        return [
            Song(name: "Paranoid Android",
                 artist: "Radiohead",
                 pedals: [
                    Pedal(name: "Shredmaster",
                          brand: "Marshall",
                          knobs: [
                            Knob(name: "volume"),
                            Knob(name: "gain"),
                            Knob(name: "Contuor")
                          ]
                         ),
                    Pedal(name: "Small Stone",
                          brand: "Eletro-Harmonix",
                          knobs: [
                            Knob(name: "Speed"),
                            Knob(name: "Tone")
                          ]
                         )
                    
                 ]
                ),
            Song(name: "Teddy Picker",
                 artist: "Arctic Monkeys",
                 pedals: [
                    Pedal(name: "Proco Rat",
                          brand: "Generic",
                          knobs: [
                            Knob(name: "volume"),
                            Knob(name: "gain"),
                            Knob(name: "Tone")
                          ]
                         )
                 ]
                )
        ]
    }
}
