//
//  PedalListViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation

class PedalListViewModel: ObservableObject {
    
    enum State {
        case empty, content
    }
    
    var user: UserApple?
    
    @Published var allPedals: [Pedal]
    @Published var isShowingSheet: Bool = false
    
    @Published var searchText: String = ""
    
    
    init(user: UserApple? = nil, allPedals: [Pedal] = []) {
        self.user = user
        self.allPedals = allPedals

    }
    
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
        allPedals = Pedal.getFamousPedals()
    }
}

extension PedalListViewModel: AddPedalDelegate {
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
                Knob(parameter: name)
            }
        }
        
        let newPedal = Pedal(name: name, brand: brand, knobs: knobs)
        allPedals.append(newPedal)
        
        isShowingSheet = false
        
    }
    
}
