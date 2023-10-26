//
//  Pedal+Populate.swift
//  PedalCore
//
//  Created by Lucas Migge on 18/10/23.
//


extension Pedal {
    static func pedalSample() -> [Pedal] {
        return [
            Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [
                Knob(name: "Drive", level: 0.7),
                Knob(name: "Tone", level: 0.5),
                Knob(name: "Level", level: 0.6)
            ]),
            Pedal(name: "Big Muff", brand: "Electro-Harmonix", knobs: [
                Knob(name: "Sustain", level: 0.8),
                Knob(name: "Tone", level: 0.4),
                Knob(name: "Volume", level: 0.7)
            ]),
            Pedal(name: "Klon Centaur", brand: "Klon", knobs: [
                Knob(name: "Gain", level: 0.6),
                Knob(name: "Treble", level: 0.5),
                Knob(name: "Output", level: 0.7)
            ]),
            Pedal(name: "DD-7 Digital Delay", brand: "BOSS", knobs: [
                Knob(name: "Delay Time", level: 0.6),
                Knob(name: "Feedback", level: 0.5),
                Knob(name: "Effect Level", level: 0.7)
            ]),
            Pedal(name: "Cry Baby Wah", brand: "Dunlop", knobs: [
                Knob(name: "Wah Range", level: 0.5),
                Knob(name: "Q", level: 0.6),
                Knob(name: "Volume", level: 0.7)
            ]),
            Pedal(name: "DS-1 Distortion", brand: "BOSS", knobs: [
                Knob(name: "Tone", level: 0.4),
                Knob(name: "Level", level: 0.7)
            ]),
            Pedal(name: "Phase 90", brand: "MXR", knobs: [
                Knob(name: "Speed", level: 0.6),
                Knob(name: "Intensity", level: 0.5)
            ]),
            Pedal(name: "Holy Grail Reverb", brand: "Electro-Harmonix", knobs: [
                Knob(name: "Reverb Type", level: 0.5),
                Knob(name: "Blend", level: 0.7)
            ]),
            Pedal(name: "CE-2 Chorus", brand: "BOSS", knobs: [
                Knob(name: "Rate", level: 0.6),
                Knob(name: "Depth", level: 0.5)
            ]),
            Pedal(name: "Tremolo", brand: "Fender", knobs: [
                Knob(name: "Speed", level: 0.7),
                Knob(name: "Intensity", level: 0.6)
            ])
        ]
    }
}
