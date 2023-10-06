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


extension Pedal {
    static func getFamousPedals() -> [Pedal] {
        return [
            Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [
                Knob(parameter: "Drive", level: 0.7),
                Knob(parameter: "Tone", level: 0.5),
                Knob(parameter: "Level", level: 0.6)
            ]),
            Pedal(name: "Big Muff", brand: "Electro-Harmonix", knobs: [
                Knob(parameter: "Sustain", level: 0.8),
                Knob(parameter: "Tone", level: 0.4),
                Knob(parameter: "Volume", level: 0.7)
            ]),
            Pedal(name: "Klon Centaur", brand: "Klon", knobs: [
                Knob(parameter: "Gain", level: 0.6),
                Knob(parameter: "Treble", level: 0.5),
                Knob(parameter: "Output", level: 0.7)
            ]),
            Pedal(name: "DD-7 Digital Delay", brand: "BOSS", knobs: [
                Knob(parameter: "Delay Time", level: 0.6),
                Knob(parameter: "Feedback", level: 0.5),
                Knob(parameter: "Effect Level", level: 0.7)
            ]),
            Pedal(name: "Cry Baby Wah", brand: "Dunlop", knobs: [
                Knob(parameter: "Wah Range", level: 0.5),
                Knob(parameter: "Q", level: 0.6),
                Knob(parameter: "Volume", level: 0.7)
            ]),
            Pedal(name: "DS-1 Distortion", brand: "BOSS", knobs: [
                Knob(parameter: "Tone", level: 0.4),
                Knob(parameter: "Level", level: 0.7)
            ]),
            Pedal(name: "Phase 90", brand: "MXR", knobs: [
                Knob(parameter: "Speed", level: 0.6),
                Knob(parameter: "Intensity", level: 0.5)
            ]),
            Pedal(name: "Holy Grail Reverb", brand: "Electro-Harmonix", knobs: [
                Knob(parameter: "Reverb Type", level: 0.5),
                Knob(parameter: "Blend", level: 0.7)
            ]),
            Pedal(name: "CE-2 Chorus", brand: "BOSS", knobs: [
                Knob(parameter: "Rate", level: 0.6),
                Knob(parameter: "Depth", level: 0.5)
            ]),
            Pedal(name: "Tremolo", brand: "Fender", knobs: [
                Knob(parameter: "Speed", level: 0.7),
                Knob(parameter: "Intensity", level: 0.6)
            ])
        ]
    }
}
