//
//  PedalDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI

struct PedalDetailView: View {
    
    @Binding var pedal: Pedal
    
    var body: some View {
        
        List {
            Section("Pedal Name") {
                Text(pedal.name)
                
            }
            
            Section("Brand") {
                Text(pedal.brand)
            }
            
            Section {
                LazyVGrid(columns: [GridItem(),GridItem()], content: {
                    ForEach(pedal.knobs.indices, id: \.self) { index in
                        KnobView(knob: $pedal.knobs[index])
                            .padding()
                    }
                })
            } header: {
                Text("Knobs")
            } footer: {
                Text("You can adjust the values the values by dragging")
            }
            
            
            
            .navigationTitle("Pedal detail")
        }
    }
}

#Preview {
    PedalDetailView(pedal: .constant(Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [
        Knob(parameter: "Drive"),
        Knob(parameter: "Tone"),
        Knob(parameter: "Level")
    ])))
}
