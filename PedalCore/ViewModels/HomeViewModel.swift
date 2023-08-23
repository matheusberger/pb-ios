//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pedals: [String] = []

    func addPedal(name: String) {
        pedals.append(name)
        print(pedals)
    }
}
