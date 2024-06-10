//
//  SongDetailViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 28/11/23.
//

import Foundation

extension Song {
    class DetailViewModel: ObservableObject {
        
        enum State {
            case presentation, editingSong, editingKnobs
        }
        
        @Published var song: Song.Model
        
        @Published var state: State = .presentation
        
        @Published var isPresentingSheet: Bool = false
        @Published var hasChanges: Bool = false
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        weak var delegate: EditDelegate?
        
        init(song: Song.Model, delegate: EditDelegate? = nil) {
            self.song = song
            self.delegate = delegate
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
        
        var pedalsUsed: [Pedal.Model]  {
            return song.pedals
        }
        
        var selectPedalView: SelectPedalView {
            SelectPedalView(allPedals: [], selectedPedals: pedalsUsed) { [self] selectedPedals in
                userDidSelectNewPedals(pedals: selectedPedals)
            }
        }
        
        public func saveButtonPressed() {
            do {
                try delegate?.updateSong(for: self.song)
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
        
        public func userDidSelectNewPedals(pedals: [Pedal.Model]) {
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
