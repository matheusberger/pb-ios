//
//  Song.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

class Song: Identifiable, Equatable, ObservableObject {
    var id: UUID
    @Published var name: String
    @Published var artist: String
    @Published var pedals: [Pedal]
    
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
