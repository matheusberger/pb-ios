//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pedals: [Pedal] = []
    
    func getPedalFormViewModel() -> PedalFormViewModel {
        let name = ""
        let brand = ""
        let knobs = [String:Int]()
        let pedal = Pedal(name: name, brand: brand, knobs: knobs)
        
        return PedalFormViewModel(pedal: pedal) { newPedal in
            self.pedals.append(newPedal)
        }
    }
}
