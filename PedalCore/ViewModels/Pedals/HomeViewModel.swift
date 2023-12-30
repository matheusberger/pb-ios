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
    
    @Published var allPedals: [Pedal] {
        didSet {
            do {
                try provider.update(allPedals)
            } catch {
                print(error)
//                isShowingAlert = true
//                alert = Alert(title: Text("Saving error"),
//                              message: Text(error.localizedDescription),
//                              dismissButton: .default(Text("OK"), action: {
//                    self.isShowingAlert = false
//                    self.alert = nil
//                }))
            }
        }
    }
    
    @Published var isShowingSheet: Bool = false
    @Published var searchText: String = ""
    
    var editPedal: Pedal?
    
    private var provider: LocalDataProvider<Pedal>
    
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
    
    init(provider: LocalDataProvider<Pedal>) {
        self.provider = provider
        self.allPedals = []
        
        load()
    }
    
    private func load() {
        do {
            try provider.load { pedals in
                self.allPedals = pedals
            }
        } catch {
            print(error)
//            isShowingAlert = true
//            alert = Alert(title: Text("Loading error"),
//                          message: Text(error.localizedDescription),
//                          dismissButton: .default(Text("OK"), action: {
//                self.isShowingAlert = false
//                self.alert = nil
//            }))
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
        allPedals = allPedals.filter { pedal in
            pedal != removedPedal
        }
    }
    
    func editPedalPressed(_ pedal: Pedal) {
        editPedal = pedal
        isShowingSheet = true
    }
    
    func sheetDidDismiss() {
        self.editPedal = nil
    }
}

extension PedalListViewModel: CreatePedalDelegate {
    func addNewPedal(_ pedal: Pedal) throws {
        
        try validadePedalInfo(pedal)
        
        self.allPedals.append(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    func finishedEditingPedal(_ pedal: Pedal) throws {
       
        try validadePedalInfo(pedal)
        
        updatePedal(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    private func validadePedalInfo(_ pedal: Pedal) throws {
        if pedal.name.isEmpty {
            throw AddPedalError.missingName
        }
        
        if pedal.brand.isEmpty {
            throw AddPedalError.missingBrand
        }
        
        if pedal.knobs.isEmpty {
            throw AddPedalError.missingKnobs
        }
        
        try pedal.knobs.forEach { knob in
            if knob.name.isEmpty {
                throw AddPedalError.missingKnobName
            }
        }
    }
    
    private func updatePedal(_ updatedPedal: Pedal) {
        allPedals = allPedals.map { pedal in
            pedal == updatedPedal ? updatedPedal : pedal
        }
    }
}
