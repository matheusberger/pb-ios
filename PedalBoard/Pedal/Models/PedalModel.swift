//
//  PedalModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

extension Pedal {
    struct Model: Identifiable, Hashable, Codable {
        var id: String = UUID().uuidString
        var name: String
        var brand: String
        var knobs: [Knob.Model]
        
        var signature: String {
            let knobNames = knobs.map { $0.name }
            
            return name + brand + knobNames.reduce("", +)
        }
        
        static func ==(lhs: Model, rhs: Model) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func emptyPedal() -> Model {
            return Model(name: "", brand: "", knobs: [])

        }
    }
}

