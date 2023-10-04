//
//  Song.swift
//  PedalCore
//
//  Created by Lucas Migge on 03/10/23.
//

import Foundation

struct Song: Identifiable {
    var id: UUID = UUID()
    var name: String
    var band: String
    var pedals: [Pedal]
    
}
