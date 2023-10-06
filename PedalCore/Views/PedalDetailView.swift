//
//  PedalDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI

struct PedalDetailView: View {
    
    //    @ObservedObject var viewModel: PedalDetailViewModel
    //
    //    init(pedal: Pedal = Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [
    //        Knob(parameter: "Drive"),
    //        Knob(parameter: "Tone"),
    //        Knob(parameter: "Level")
    //    ])) {
    //        self.viewModel = PedalDetailViewModel(pedal: pedal)
    //    }
    
    var pedal: Pedal
    
    
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
                    ForEach(pedal.knobs, id: \.parameter) { knob in
                        KnobView(viewModel: KnobViewModel(knob: knob))
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
    PedalDetailView(pedal: Pedal(name: "Tube Screamer", brand: "Ibanez", knobs: [
        Knob(parameter: "Drive"),
        Knob(parameter: "Tone"),
        Knob(parameter: "Level")
    ]))
}
