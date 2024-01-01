//
//  PedalRow.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

extension Pedal.List {
    struct Row: SwiftUI.View {
        var pedal: Pedal.Model
        
        var body: some SwiftUI.View {
            VStack(alignment: .leading) {
                Text(pedal.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(pedal.brand)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    ForEach(pedal.knobs, id: \.id) {
                        Text($0.name)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

struct PedalRow_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        Pedal.List.Row(pedal: Pedal.Model(name: "Big Muff Pi",
                              brand: "Eletro Hamonix",
                                          knobs: [    Knob.Model(name: "Volume", level: 0.25),
                                                      Knob.Model(name: "Tone", level: 0.5),
                                                      Knob.Model(name: "Gain", level: 0.9)
                                     ]
                             )
        )
    }
}
