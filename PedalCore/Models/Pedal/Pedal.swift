//
//  Pedal.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

struct Pedal: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var brand: String
    var knobs: [Knob]
    
    static func ==(lhs: Pedal, rhs: Pedal) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

