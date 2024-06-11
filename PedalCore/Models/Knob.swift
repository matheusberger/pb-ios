//
//  Knob.swift
//  PedalCore
//
//  Created by Matheus Berger on 10/06/24.
//

import Foundation

/// Representation for a pedal knob
public struct Knob: Identifiable, Codable {
    public var id: UUID
    
    /// Knob label
    public var name: String
    /// Intensity of Knob. Range 0 to 1
    public var level: Float
    
    public init(id: UUID = UUID(), name: String, level: Float = 0.5) {
        self.id = id
        self.name = name
        self.level = level
    }
}
