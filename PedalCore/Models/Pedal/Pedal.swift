//
//  Pedal.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

struct Pedal: Identifiable, Equatable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var brand: String
    var knobs: [Knob]
    
    var signature: String {
        let knobNames = knobs.map { $0.name }
        
        return name + brand + knobNames.reduce("", +)
    }
    
    static func ==(lhs: Pedal, rhs: Pedal) -> Bool {
        return lhs.id == rhs.id
    }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func emptyPedal() -> Pedal {
        return Pedal(name: "", brand: "", knobs: [])

    }
}

