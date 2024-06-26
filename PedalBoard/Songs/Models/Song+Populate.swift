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
                 pedals: [Pedal.pedalSample()[0],
                          Pedal.pedalSample()[1],
                          Pedal.pedalSample()[2]
                         ]
                ),
            Song(name: "Teddy Picker",
                 artist: "ArcticMonkeys",
                 pedals: [Pedal.pedalSample()[2],
                          Pedal.pedalSample()[3]
                         ]
                ),
            
        ]
    }
}
