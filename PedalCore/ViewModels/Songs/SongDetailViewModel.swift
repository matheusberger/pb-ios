//
//  SongDetailViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 28/11/23.
//

import Foundation

class SongDetailViewModel: ObservableObject {
    @Published var song: Song
    
    @Published var isPresentingSheet: Bool = false
    @Published var hasChanges: Bool = false
    @Published var isEditingKnobs: Bool = false
    @Published var isEditingMusic: Bool = false
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    weak var delegate: AddSongDelegate?
    
    init(song: Song, delegate: AddSongDelegate? = nil) {
        self.song = song
        self.delegate = delegate
    }
    
    var isEditing: Bool {
        return isEditingKnobs || isEditingMusic
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
    
    public func userDidSelectNewPedals(pedals: [Pedal]) {
        isEditingKnobs = false
        song.pedals = pedals
    }
    
    public func editSongPressed() {
        hasChanges = true
        isEditingKnobs = false
        isEditingMusic.toggle()
        
    }
    
    func editKnobsPressed() {
        hasChanges = true
        isEditingKnobs.toggle()
    }
    
}
