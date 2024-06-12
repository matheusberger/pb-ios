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
        // This id is necessary to make it Hashable
        private var id: UUID = UUID()
        
        @Published public var songName: String = ""
        @Published var bandName: String = ""
        @Published var pedalList: [Pedal] = []
        
        @Published var isPresentingSheet: Bool = false
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        private(set) var availablePedals: [Pedal]
        var selectPedalView: SelectPedalView {
            SelectPedalView(allPedals: availablePedals, selectedPedals: pedalList) { [self] selectedPedals in
                updateSelectedPedals(selectedPedals)
            }
        }
        
        private var onSave: (_ song: Song) -> Void
        
        init(availablePedals: [Pedal], _ onSave: @escaping (_ song: Song) -> Void) {
            self.availablePedals = availablePedals
            self.onSave = onSave
        }
        
        public func removePedal(at index: IndexSet) {
            self.pedalList.remove(atOffsets: index)
        }
        
        public func removePedal(_ pedal: Pedal) {
            self.pedalList = pedalList.filter({ $0.id != pedal.id})
        }
        
        public func updateSelectedPedals(_ pedals: [Pedal]) {
            self.pedalList = pedals
        }
        
        public func attachPedalPressed() {
            self.isPresentingSheet = true

        }
        
        public func addSongPressed() async {
            do {
                let song = Song(name: songName, artist: bandName, pedals: pedalList)
                try validateSong(song)
                
                onSave(song)
            } catch {
                if let songError = error as? EditError {
                    alertMessage = songError.alertDescription
                    isPresentingAlert = true
                }
            }
        }
        
        private func validateSong(_ song: Song) throws {
            if song.name.isEmpty {
                throw Song.EditError.missingName
            }
            
            if song.artist.isEmpty {
                throw Song.EditError.missingArtist
            }
        }
    }
}

/// Hashable extension to enable navigation view NavigationLink(value:)
extension Song.EditViewModel: Hashable {
    static func == (lhs: Song.EditViewModel, rhs: Song.EditViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
