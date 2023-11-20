//
//  KnobsGridView.swift
//  PedalCore
//
//  Created by Lucas Migge on 20/11/23.
//

import SwiftUI

struct KnobsGridView: View {
    
    @Binding var knobs: [Knob]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(),GridItem()]) {
            ForEach($knobs) { $knobs in
                KnobView(knob: $knobs)
                    .padding()
            }
        }
    }
}


struct KnobsGridView_Previews: PreviewProvider {
    static var previews: some View {
        KnobsGridView(knobs: .constant(Pedal.pedalSample().first!.knobs))
    }
}
