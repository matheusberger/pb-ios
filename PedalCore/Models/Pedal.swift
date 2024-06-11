//
//  Pedal.swift
//  PedalCore
//
//  Created by Matheus Berger on 10/06/24.
//

import Foundation

public struct Pedal: Identifiable, Hashable, Codable {
    public var id: String = UUID().uuidString
    public var name: String
    public var brand: String
    public var knobs: [Knob]
    
    public var signature: String {
        let knobNames = knobs.map { $0.name }
        
        return name + brand + knobNames.reduce("", +)
    }
    
    public init(id: String = "", name: String, brand: String, knobs: [Knob]) {
        self.id = id
        self.name = name
        self.brand = brand
        self.knobs = knobs
    }
    
    static public func ==(lhs: Pedal, rhs: Pedal) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func emptyPedal() -> Pedal {
        return .init(name: "", brand: "", knobs: [])

    }
}
