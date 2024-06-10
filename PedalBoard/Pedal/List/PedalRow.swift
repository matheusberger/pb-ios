//
//  PedalRow.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

extension Pedal {
    struct ListRow: View {
        var pedal: Pedal.Model
        
        var body: some View {
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
    static var previews: some View {
        Pedal.ListRow(pedal: Pedal.Model(name: "Big Muff Pi",
                              brand: "Eletro Hamonix",
                                          knobs: [    Pedal.Knob(name: "Volume", level: 0.25),
                                                      Pedal.Knob(name: "Tone", level: 0.5),
                                                      Pedal.Knob(name: "Gain", level: 0.9)
                                     ]
                             )
        )
    }
}
