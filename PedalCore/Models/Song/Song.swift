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
    var pedals: [Pedal]
    
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}
