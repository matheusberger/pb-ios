//
//  PedalListViewModel.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import Foundation
import PedalCore

extension Pedal {
    @MainActor
    class ListViewModel: ObservableObject {

        enum State {
            case empty, content
        }
        
        @Published var searchText: String = ""
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
        
        private var provider: any DataProviderProtocol<Pedal>
        private var navigationModel: NavigationModel?
        
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
        
        func removePedalPressed(_ removedPedal: Pedal) {
            allPedals = allPedals.filter { pedal in
                pedal != removedPedal
            }
        }
        
        func setNavigationModel(_ navigationModel: NavigationModel) {
            self.navigationModel = navigationModel
        }
    }
}

/// Navigation
extension Pedal.ListViewModel {
    // EditViewModel for NEW PEDAL
    var editViewModel: Pedal.EditViewModel {
        return .init { pedal in
            self.allPedals.append(pedal)
            self.navigationModel?.pop()
        }
    }
    
    // EditViewModel for edit button
    func editViewModel(_ pedal: Pedal) -> Pedal.EditViewModel {
        return .init(pedal) { updatedPedal in
            self.allPedals = self.allPedals.map { pedal in
                pedal == updatedPedal ? updatedPedal : pedal
            }
            self.navigationModel?.pop()
        }
    }
}
