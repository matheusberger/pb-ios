//
//  Song.swift
//  PedalCore
//
//  Created by Matheus Berger on 10/06/24.
//

import Foundation

public struct Song: Hashable, Codable {
    public var id: UUID = UUID()
    public var name: String
    public var artist: String
    public var pedals: [Pedal]
    
    public init(id: UUID = UUID(), name: String, artist: String, pedals: [Pedal]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.pedals = pedals
    }
    
    public var signature: String {
        let pedalNames = pedals.map { $0.name }
        
        return name + artist + pedalNames.reduce("", +)
    }
    
    static public func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}
