//
//  PedalFormViewModel.swift
//  PedalCore
//
//  Created by Migge on 12/09/23.
//

import Foundation
import SwiftUI

class PedalFormViewModel: ObservableObject {
    @Published var name: String
    @Published var brand: String
    @Published var knobNames: [String]
    
    var pedal: Pedal
    let completion: (Pedal) -> Void
    
    init(pedal: Pedal, completion: @escaping (Pedal) -> Void) {
        self.pedal = pedal
        self.name = pedal.name
        self.brand = pedal.brand
        self.knobNames = Array(pedal.knobs.keys)
        self.completion = completion
    }
    
    func save() {
        let knobs = Dictionary(uniqueKeysWithValues: knobNames.map { name in
                    (name, 0)
        })
        let newPedal = Pedal(name: name, brand: brand, knobs: knobs)
        completion(newPedal)
        
        name = ""
        brand = ""
        knobNames = []
    }
}
