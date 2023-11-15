//
//  Song.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

struct Song: Identifiable {
    var id: UUID = UUID()
    var name: String
    var artist: String
    var pedals: [Pedal]
    
}
