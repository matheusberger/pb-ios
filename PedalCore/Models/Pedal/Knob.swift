//
//  Knob.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import Foundation

/// Representation for a pedal knob
public struct Knob: Identifiable, Codable {
    public var id: UUID = UUID()
    
    /// Knob label
    var name: String
    /// Intensity of Knob. Range 0 to 1
    var level: Float = 0.5
    
}
