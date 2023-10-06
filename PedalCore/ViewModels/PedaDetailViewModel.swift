//
//  PedalDetailViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import Foundation

class PedalDetailViewModel: ObservableObject {
    
    @Published var pedal: Pedal
    
    var name: String {
        pedal.name
    }
    
    var brand: String {
        pedal.brand
    }
    
    var knobs: [Knob] {
        pedal.knobs
    }
    
    init(pedal: Pedal) {
        self.pedal = pedal
        
    }
}
