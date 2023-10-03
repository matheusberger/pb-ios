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
        }
    }
}

struct PedalRow_Previews: PreviewProvider {
    static var previews: some View {
        PedalRow(pedal: Pedal(name: "Big Muff Pi",
                              brand: "Eletro Hamonix",
                              knobs: [    Knob(name: "Volume"),
                                          Knob(name: "Tone"),
                                          Knob(name: "Gain")
                                     ]
                             )
        )
    }
}
