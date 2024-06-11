//
//  SongDetailViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 28/11/23.
//

import Foundation
import PedalCore

extension Song {
    class DetailViewModel: ObservableObject {
        
        enum State {
            case presentation, editingSong, editingKnobs
        }
        
        @Published var song: Song
        
        @Published var state: State = .presentation
        
        @Published var isPresentingSheet: Bool = false
        @Published var hasChanges: Bool = false
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        private let pedalProvider: any DataProviderProtocol<Pedal>
        
        init(song: Song, pedalProvider: any DataProviderProtocol<Pedal>) {
            self.song = song
            self.pedalProvider = pedalProvider
        }
        
        var isInEditing: Bool {
            return state != .presentation
        }
        
        var isInPresentationMode: Bool {
            return state == .presentation
        }
        
        
        var isInEditingSongMode: Bool {
            return state == .editingSong
        }
        
        var isInEditingKnobsMode: Bool {
            return state == .editingKnobs
        }
        
        var pedalsUsed: [Pedal]  {
            return song.pedals
        }
        
        var selectPedalView: SelectPedalView {
            SelectPedalView(allPedals: pedalProvider.data, selectedPedals: pedalsUsed) { [self] selectedPedals in
                userDidSelectNewPedals(pedals: selectedPedals)
            }
        }
        
        public func saveButtonPressed() async {
            do {
                //try await delegate?.updateSong(for: self.song)
            } catch {
                if let songError = error as? EditError {
                    alertMessage = songError.alertDescription
                    isPresentingAlert = true
                }
            }
        }
        
        public func ChangePedalsButtonPressed() {
            isPresentingSheet.toggle()
        }
        
        public func userDidSelectNewPedals(pedals: [Pedal]) {
            song.pedals = pedals
        }
        
        public func editSongPressed() {
            hasChanges = true
            state = state == .presentation ? .editingSong : .presentation
            
        }
        
        func editKnobsPressed() {
            hasChanges = true
            
            switch state {
            case .presentation:
                state = .editingKnobs
            case .editingSong:
                return
            case .editingKnobs:
                state = .presentation
            }
        }
    }
}
