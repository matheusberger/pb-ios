//
//  KnobModel.swift
//  PedalBoard
//
//  Created by Matheus Berger on 30/12/23.
//

import Foundation

extension Knob {
    /// Representation for a pedal knob
    struct Model: Identifiable, Codable {
        var id: UUID = UUID()
        
        /// Knob label
        var name: String
        /// Intensity of Knob. Range 0 to 1
        var level: Float = 0.5
        
    }
}
