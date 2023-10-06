//
//  PedalRow.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

struct PedalRow: View {
    
    var pedal: Pedal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pedal.name)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(pedal.brand)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            ScrollView(.horizontal) {
                HStack(spacing: 30) {
                    ForEach(pedal.knobs, id: \.parameter) { knob in
                        KnobView(viewModel: KnobViewModel(knob: knob))
                    }
                }
                .padding(.horizontal, 10)
                
            }
        }
    }
}

struct PedalRow_Previews: PreviewProvider {
    static var previews: some View {
        PedalRow(pedal: Pedal(name: "Big Muff Pi",
                              brand: "Eletro Hamonix",
                              knobs: [    Knob(parameter: "Volume", level: 0.25),
                                          Knob(parameter: "Tone", level: 0.5),
                                          Knob(parameter: "Gain", level: 0.9)
                                     ]
                             )
        )
    }
}
