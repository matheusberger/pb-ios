//
//  SongModel.swift
//  PedalCore
//
//  Created by Matheus Berger on 30/12/23.
//

import Foundation

struct Song: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var artist: String
    var pedals: [Pedal]
    
    init(id: UUID = UUID(), name: String, artist: String, pedals: [Pedal]) {
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
