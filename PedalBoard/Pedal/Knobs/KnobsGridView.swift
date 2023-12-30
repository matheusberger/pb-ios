//
//  KnobsGridView.swift
//  PedalCore
//
//  Created by Lucas Migge on 20/11/23.
//

import SwiftUI

extension Knob {
    struct GridView: SwiftUI.View {
        
        @Binding var knobs: [Model]
        var knobStyle: KnobViewStyle = .editing
        
        var minimumDistance: CGFloat {
            switch knobStyle {
            case .reference:
                return 70
            case .editing:
                return 100
            }
        }
        
        var body: some SwiftUI.View {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumDistance, maximum: 120))], spacing: 30) {
                    ForEach($knobs) { $knobs in
                        View(knob: $knobs, knobViewStyle: knobStyle)
                    }
                }
            }
        }
    }
}

struct KnobsGridView_Previews: PreviewProvider {
    static var previews: some View {
        Knob.GridView(knobs: .constant(Pedal.pedalSample().first!.knobs))
    }
}
