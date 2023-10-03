//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pedals: [Pedal] = []
    @Published var isShowingSheet: Bool = false


    func addIconPressed() {
        isShowingSheet = true
    }
}

extension HomeViewModel: AddPedalDelegate {
    func addPedalPressed(name: String, brand: String, knobNames: [String]) throws {
        if name.isEmpty {
            throw AddPedalError.missingName
        }
        
        if brand.isEmpty {
            throw AddPedalError.missingBrand
        }
        
        if knobNames.isEmpty {
            throw AddPedalError.missingKnobs
        }
        
        
        var knobs: [Knob] {
            knobNames.map { name in
                Knob(name: name)
            }
        }
        
        let newPedal = Pedal(name: name, brand: brand, knobs: knobs)
        pedals.append(newPedal)
        isShowingSheet = false
        
        
    }
    
    
    
    
}
