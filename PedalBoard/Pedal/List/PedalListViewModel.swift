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
        
        private var provider: any DataProviderProtocol<Pedal>
        
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
        
        init(provider: any DataProviderProtocol<Pedal>) {
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
}

extension Pedal.ListViewModel {
    func addNewPedal(_ pedal: Pedal) {
        self.allPedals.append(pedal)
        editPedal = nil
    }
    
    public func updatePedal(_ updatedPedal: Pedal) {
        editPedal = nil
        allPedals = allPedals.map { pedal in
            pedal == updatedPedal ? updatedPedal : pedal
        }
    }
}
