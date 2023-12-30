//
//  Song.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

struct Song: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var artist: String
    var pedals: [Pedal.Model]
    
    init(id: UUID = UUID(), name: String, artist: String, pedals: [Pedal.Model]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.pedals = pedals
    }
    
    var signature: String {
        let pedalNames = pedals.map { $0.name }
        
        return name + artist + pedalNames.reduce("", +)
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}
