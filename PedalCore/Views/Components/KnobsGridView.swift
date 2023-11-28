//
//  KnobsGridView.swift
//  PedalCore
//
//  Created by Lucas Migge on 20/11/23.
//

import SwiftUI

struct KnobsGridView: View {
    
    @Binding var knobs: [Knob]
    var knobStyle: KnobViewStyle = .editing
    
    var minimumDistance: CGFloat {
        switch knobStyle {
        case .reference:
            return 70
        case .editing:
            return 100
        }
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumDistance, maximum: 120))], spacing: 30) {
                ForEach($knobs) { $knobs in
                    KnobView(knob: $knobs, knobViewStyle: knobStyle)
                }
            }
        }
    }
}


struct KnobsGridView_Previews: PreviewProvider {
    static var previews: some View {
        KnobsGridView(knobs: .constant(Pedal.pedalSample().first!.knobs))
    }
}
