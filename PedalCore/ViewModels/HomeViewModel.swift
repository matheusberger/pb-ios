//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pedals: [Pedal] = []

    func addPedal(name: String, brand: String, knobNames: [String]) {
        let knobs = Dictionary(uniqueKeysWithValues: knobNames.map { name in
            (name, 0)
        })
        let newPedal = Pedal(name: name, brand: brand, knobs: knobs)
        pedals.append(newPedal)
    }
}
