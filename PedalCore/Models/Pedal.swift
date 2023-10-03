//
//  Pedal.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

struct Pedal: Identifiable {
    var id: UUID = UUID()
    var name: String
    var brand: String
    var knobs: [Knob]
    
}
