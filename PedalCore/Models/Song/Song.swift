//
//  Song.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

struct Song: Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var artist: String
    var pedals: [Pedal]
    
    var signature: String {
        let pedalNames = pedals.map { $0.name }
        
        return name + artist + pedalNames.reduce("", +)
    }
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}
