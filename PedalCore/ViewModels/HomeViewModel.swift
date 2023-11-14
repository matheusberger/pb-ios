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
    
    var editPedal: Pedal?
    
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
    
    
    func removePedalPressed(_ removedPedal: Pedal) {
//        guard let pedalIndex = allPedals.firstIndex(of: pedal) else { return }
//        
//        allPedals.remove(at: pedalIndex)
        
        allPedals = allPedals.filter { pedal in
            pedal != removedPedal
        }
    }
    
    func editPedalPressed(_ pedal: Pedal) {
        
        editPedal = pedal
        isShowingSheet = true
        
    }
}

extension HomeViewModel: AddPedalDelegate {
    func addNewPedal(_ pedal: Pedal) throws {
        if pedal.name.isEmpty {
            throw AddPedalError.missingName
        }
        
        if pedal.brand.isEmpty {
            throw AddPedalError.missingBrand
        }
        
        if pedal.knobs.isEmpty {
            throw AddPedalError.missingKnobs
        }
        
        self.allPedals.append(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    func finishedEditingPedal(_ pedal: Pedal) throws {
        if pedal.name.isEmpty {
            throw AddPedalError.missingName
        }
        
        if pedal.brand.isEmpty {
            throw AddPedalError.missingBrand
        }
        
        if pedal.knobs.isEmpty {
            throw AddPedalError.missingKnobs
        }
        

        updatePedal(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    
    func updatePedal(_ updatedPedal: Pedal) {
        
        allPedals = allPedals.map { pedal in
            pedal == updatedPedal ? updatedPedal : pedal
        }
        
    }
}
