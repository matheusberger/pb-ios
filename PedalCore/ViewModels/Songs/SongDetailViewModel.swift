//
//  SongDetailViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 28/11/23.
//

import Foundation
import SwiftUI

class SongDetailViewModel: ObservableObject {
    
    enum State {
        case presentation, editingSong, editingKnobs
    }
    
    @Published var song: Song
    
    @Published var state: State = .presentation
    
    @Published var isPresentingSheet: Bool = false
    @Published var hasChanges: Bool = false
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    weak var delegate: AddSongDelegate?
    
    init(song: Song, delegate: AddSongDelegate? = nil) {
        self.song = song
        self.delegate = delegate
    }
    
    public var isInEditing: Bool {
        return state != .presentation
    }
    
    public var isInPresentationMode: Bool {
        return state == .presentation
    }
    
    
    public var isInEditingSongMode: Bool {
        return state == .editingSong
    }
    
    public var isInEditingKnobsMode: Bool {
        return state == .editingKnobs
    }
    
    var pedalsUsed: [Pedal]  {
        return song.pedals
    }
    
    public func saveButtonPressed() {
        do {
            try delegate?.updateSong(for: self.song)
        } catch {
            if let songError = error as? AddSongError {
                alertMessage = songError.alertDescription
                isPresentingAlert = true
                
            }
        }
    }
    
    public func ChangePedalsButtonPressed() {
        isPresentingSheet.toggle()
    }
    
    #warning("Delete this on the future")
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

extension SongDetailViewModel: SelectPedalDelegate {
    func didFinishSelectingPedals(_ pedals: [Pedal]) {
        withAnimation {
            song.pedals = pedals
        }
    }

}
