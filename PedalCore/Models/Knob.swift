//
//  Knob.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import Foundation

/// Representation for a pedal knob
struct Knob {
    var id: UUID = UUID()
    
    /// Knob label
    var parameter: String
    /// Intensity of Knob. Range 0 to 1
    var level: Float = 0.5
    
}
