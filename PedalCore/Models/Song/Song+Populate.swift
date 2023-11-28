//
//  Song+Populate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

extension Song {
    static func getSample() -> [Song] {
        return [
            Song(name: "Paranoid Android",
                 artist: "Radiohead",
                 pedals: [
                    Pedal(name: "Shredmaster", brand: "Marshall",
                          knobs: [
                            Knob(name: "Gain"),
                            Knob(name: "Treble"),
                            Knob(name: "Contour"),
                            Knob(name: "Bass"),
                            Knob(name: "Volume")
                          ]),
                    Pedal(name: "Small Stone",
                          brand: "Eletro-Harmonix",
                          knobs: [
                            Knob(name: "Speed"),
                            Knob(name: "Tone")
                          ]),
                    Pedal(name: "Tremulator", brand: "Demeter",
                          knobs: [Knob(name: "Level"), Knob(name: "Intensity")])
                 ]
                ),
            Song(name: "Teddy Picker",
                 artist: "Arctic Monkeys",
                 pedals: [
                    Pedal(name: "Proco Rat",
                          brand: "Generic",
                          knobs: [
                            Knob(name: "volume"),
                            Knob(name: "gain"),
                            Knob(name: "Tone")
                          ]
                         )
                 ]),
            Song(name: "Bohemian Rhapsody",
                           artist: "Queen",
                           pedals: [
                              Pedal(name: "Brian May Treble Booster", brand: "KAT",
                                    knobs: [
                                      Knob(name: "Gain"),
                                      Knob(name: "Treble"),
                                      Knob(name: "Bass"),
                                      Knob(name: "Volume")
                                    ]),
                              Pedal(name: "Red Special", brand: "DigiTech",
                                    knobs: [
                                      Knob(name: "Delay"),
                                      Knob(name: "Modulation"),
                                      Knob(name: "Reverb")
                                    ]),
                              Pedal(name: "Boss DS-1", brand: "Boss",
                                    knobs: [Knob(name: "Level"), Knob(name: "Tone"), Knob(name: "Distortion")])
                           ]
                      ),
                      Song(name: "Stairway to Heaven",
                           artist: "Led Zeppelin",
                           pedals: [
                              Pedal(name: "MXR Phase 90", brand: "MXR",
                                    knobs: [
                                      Knob(name: "Speed"),
                                      Knob(name: "Intensity")
                                    ]),
                              Pedal(name: "Fender Reverb", brand: "Fender",
                                    knobs: [
                                      Knob(name: "Dwell"),
                                      Knob(name: "Mix"),
                                      Knob(name: "Tone")
                                    ])
                           ]
                      ),
                      Song(name: "Imagine",
                           artist: "John Lennon",
                           pedals: [
                              Pedal(name: "Steinway Grand Piano", brand: "Steinway & Sons",
                                    knobs: [
                                      Knob(name: "Volume"),
                                      Knob(name: "Sustain")
                                    ])
                           ]
                      ),
                      Song(name: "Hotel California",
                           artist: "Eagles",
                           pedals: [
                              Pedal(name: "Wah-Wah", brand: "Cry Baby",
                                    knobs: [
                                      Knob(name: "Toe Down"),
                                      Knob(name: "Heel Down")
                                    ]),
                              Pedal(name: "Gibson Echoplex", brand: "Gibson",
                                    knobs: [Knob(name: "Delay"), Knob(name: "Sustain")])
                           ]
                      ),
                      Song(name: "Hey Jude",
                           artist: "The Beatles",
                           pedals: [
                              Pedal(name: "Hofner Bass Fuzz", brand: "Hofner",
                                    knobs: [
                                      Knob(name: "Fuzz"),
                                      Knob(name: "Tone"),
                                      Knob(name: "Volume")
                                    ]),
                              Pedal(name: "Rickenbacker Compressor", brand: "Rickenbacker",
                                    knobs: [Knob(name: "Attack"), Knob(name: "Sustain")])
                           ]
                      ),
                      Song(name: "Purple Haze",
                           artist: "Jimi Hendrix",
                           pedals: [
                              Pedal(name: "Fuzz Face", brand: "Arbiter",
                                    knobs: [
                                      Knob(name: "Fuzz"),
                                      Knob(name: "Volume")
                                    ]),
                              Pedal(name: "Uni-Vibe", brand: "Shin-Ei",
                                    knobs: [Knob(name: "Speed"), Knob(name: "Intensity")])
                           ]
                      ),
                      Song(name: "Like a Rolling Stone",
                           artist: "Bob Dylan",
                           pedals: [
                              Pedal(name: "Harmonica", brand: "Hohner",
                                    knobs: [
                                      Knob(name: "Bending"),
                                      Knob(name: "Tone")
                                    ])
                           ]
                      ),
                      Song(name: "What's Going On",
                           artist: "Marvin Gaye",
                           pedals: [
                              Pedal(name: "Saxophone", brand: "Selmer",
                                    knobs: [
                                      Knob(name: "Vibrato"),
                                      Knob(name: "Reed")
                                    ])
                           ]
                      ),
                      Song(name: "Superstition",
                           artist: "Stevie Wonder",
                           pedals: [
                              Pedal(name: "Clavinet", brand: "Hohner",
                                    knobs: [
                                      Knob(name: "Filter"),
                                      Knob(name: "Volume")
                                    ])
                           ]
                      ),
                      Song(name: "Smells Like Teen Spirit",
                           artist: "Nirvana",
                           pedals: [
                              Pedal(name: "Fender Mustang", brand: "Fender",
                                    knobs: [
                                      Knob(name: "Volume"),
                                      Knob(name: "Tone")
                                    ]),
                              Pedal(name: "Big Muff", brand: "Electro-Harmonix",
                                    knobs: [Knob(name: "Sustain"), Knob(name: "Tone")])
        ])
        ]
    }
}
