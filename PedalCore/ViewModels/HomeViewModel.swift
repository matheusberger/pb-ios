//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {

    enum State {
        case empty, content
    }
    
    @Published var allPedals: [Pedal] = []
    @Published var isShowingSheet: Bool = false
    @Published var searchText: String = ""
    
    var state: State {
        if allPedals.isEmpty {
            return .empty
        } else {
            return .content
        }
    }
    
    public var filteredPedals: [Pedal] {
        if searchText.isEmpty {
            return allPedals
        } else {
            return allPedals.filter { pedal in
                pedal.name.localizedCaseInsensitiveContains(searchText) || pedal.brand.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func addIconPressed() {
        isShowingSheet = true
    }
    
    // for debugging
    func populatePedals() {
        allPedals = Pedal.pedalSample()
    }
    
    
    public func removePedal(_ pedal: Pedal) {
        guard let pedalIndex = allPedals.firstIndex(of: pedal) else { return }
        
        allPedals.remove(at: pedalIndex)
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
        allPedals.append(newPedal)
        
        isShowingSheet = false
    }
}
