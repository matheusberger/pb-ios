//
//  PedalModel+Populate.swift
//  PedalCore
//
//  Created by Lucas Migge on 18/10/23.
//


extension Pedal {
    static func pedalSample() -> [Pedal.Model] {
        return [
            Model(id: "01", name: "Shredmaster", brand: "Marshall", knobs: [
               Knob.Model(name: "Gain"), 
               Knob.Model(name: "Treble"),
               Knob.Model(name: "Contour"),
               Knob.Model(name: "Bass"),
               Knob.Model(name: "Volume")
            ]),
            Model(id: "012", name: "Tube Screamer", brand: "Ibanez", knobs: [
                Knob.Model(name: "Drive", level: 0.7),
                Knob.Model(name: "Tone", level: 0.5),
                Knob.Model(name: "Level", level: 0.6)
            ]),
            Model(id: "03", name: "Big Muff", brand: "Electro-Harmonix", knobs: [
                Knob.Model(name: "Sustain", level: 0.8),
                Knob.Model(name: "Tone", level: 0.4),
                Knob.Model(name: "Volume", level: 0.7)
            ]),
            Model(id: "04", name: "Klon Centaur", brand: "Klon", knobs: [
                Knob.Model(name: "Gain", level: 0.6),
                Knob.Model(name: "Treble", level: 0.5),
                Knob.Model(name: "Output", level: 0.7)
            ]),
            Model(id: "05", name: "DD-7 Digital Delay", brand: "BOSS", knobs: [
                Knob.Model(name: "Delay Time", level: 0.6),
                Knob.Model(name: "Feedback", level: 0.5),
                Knob.Model(name: "Effect Level", level: 0.7)
            ]),
            Model(id: "06", name: "Cry Baby Wah", brand: "Dunlop", knobs: [
                Knob.Model(name: "Wah Range", level: 0.5),
                Knob.Model(name: "Q", level: 0.6),
                Knob.Model(name: "Volume", level: 0.7)
            ]),
            Model(id: "07", name: "DS-1 Distortion", brand: "BOSS", knobs: [
                Knob.Model(name: "Tone", level: 0.4),
                Knob.Model(name: "Level", level: 0.7)
            ]),
            Model(id: "08", name: "Phase 90", brand: "MXR", knobs: [
                Knob.Model(name: "Speed", level: 0.6),
                Knob.Model(name: "Intensity", level: 0.5)
            ]),
            Model(id: "09", name: "Holy Grail Reverb", brand: "Electro-Harmonix", knobs: [
                Knob.Model(name: "Reverb Type", level: 0.5),
                Knob.Model(name: "Blend", level: 0.7)
            ]),
            Model(id: "10", name: "CE-2 Chorus", brand: "BOSS", knobs: [
                Knob.Model(name: "Rate", level: 0.6),
                Knob.Model(name: "Depth", level: 0.5)
            ]),
            Model(id: "11", name: "Tremolo", brand: "Fender", knobs: [
                Knob.Model(name: "Speed", level: 0.7),
                Knob.Model(name: "Intensity", level: 0.6)
            ])
        ]
    }
}
