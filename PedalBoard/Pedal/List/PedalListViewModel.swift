//
//  PedalListViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation
import PedalCore

extension Pedal {
    class ListViewModel: ObservableObject {

        enum State {
            case empty, content
        }
        
        @Published var allPedals: [Pedal.Model] {
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
        
        var editPedal: Pedal.Model?
        
        private var provider: LocalDataProvider<Pedal.Model>
        
        var state: State {
            if allPedals.isEmpty {
                return .empty
            } else {
                return .content
            }
        }
        
        public var filteredPedals: [Pedal.Model] {
            if searchText.isEmpty {
                return allPedals
            } else {
                return allPedals.filter { pedal in
                    pedal.name.localizedCaseInsensitiveContains(searchText) || pedal.brand.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        init(provider: LocalDataProvider<Pedal.Model>) {
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
        
        func removePedalPressed(_ removedPedal: Pedal.Model) {
            allPedals = allPedals.filter { pedal in
                pedal != removedPedal
            }
        }
        
        func editPedalPressed(_ pedal: Pedal.Model) {
            editPedal = pedal
            isShowingSheet = true
        }
        
        func sheetDidDismiss() {
            self.editPedal = nil
        }
    }
}

extension Pedal.ListViewModel: Pedal.EditDelegate {
    func addNewPedal(_ pedal: Pedal.Model) throws {
        
        try validadePedalInfo(pedal)
        
        self.allPedals.append(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    func finishedEditingPedal(_ pedal: Pedal.Model) throws {
       
        try validadePedalInfo(pedal)
        
        updatePedal(pedal)
        
        editPedal = nil
        isShowingSheet = false
    }
    
    private func validadePedalInfo(_ pedal: Pedal.Model) throws {
        if pedal.name.isEmpty {
            throw Pedal.EditError.missingName
        }
        
        if pedal.brand.isEmpty {
            throw Pedal.EditError.missingBrand
        }
        
        if pedal.knobs.isEmpty {
            throw Pedal.EditError.missingKnobs
        }
        
        try pedal.knobs.forEach { knob in
            if knob.name.isEmpty {
                throw Pedal.EditError.missingKnobName
            }
        }
    }
    
    private func updatePedal(_ updatedPedal: Pedal.Model) {
        allPedals = allPedals.map { pedal in
            pedal == updatedPedal ? updatedPedal : pedal
        }
    }
}
