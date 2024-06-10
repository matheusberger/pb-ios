//
//  CreateSongViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation
import SwiftUI
import PedalCore

extension Song {
    class EditViewModel: ObservableObject {
        
        weak var delegate: EditDelegate?
        
        var availablePedals: [Pedal.Model] {
            return provider.data
        }
        
        var selectPedalView: SelectPedalView {
            SelectPedalView(allPedals: availablePedals, selectedPedals: pedalList) { [self] selectedPedals in
                updateSelectedPedals(selectedPedals)
            }
        }
        
        @Published public var songName: String = ""
        @Published var bandName: String = ""
        @Published var pedalList: [Pedal.Model] = []
        
        @Published var isPresentingSheet: Bool = false
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        private let provider: any DataProviderProtocol<Pedal.Model>
        
        init(pedalProvider: any DataProviderProtocol<Pedal.Model>, delegate: EditDelegate? = nil) {
            self.provider = pedalProvider
            self.delegate = delegate
        }
        
        public func removePedal(at index: IndexSet) {
            self.pedalList.remove(atOffsets: index)
        }
        
        public func removePedal(_ pedal: Pedal.Model) {
            self.pedalList = pedalList.filter({ $0.id != pedal.id})
        }
        
        public func updateSelectedPedals(_ pedals: [Pedal.Model]) {
            self.pedalList = pedals
        }
        
        public func attachPedalPressed() {
            self.isPresentingSheet = true

        }
        
        public func addSongPressed() {
            do {
                let song = Song.Model(name: songName, artist: bandName, pedals: pedalList)
                try delegate?.addSong(song)
                
            } catch {
                if let songError = error as? EditError {
                    alertMessage = songError.alertDescription
                    isPresentingAlert = true
                    
                }
            }
        }
    }
}
