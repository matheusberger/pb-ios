//
//  CreateSongViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation
import SwiftUI

class CreateSongViewModel: ObservableObject {
    
    weak var delegate: AddSongDelegate?
    
//    @Binding var editSong: Song?
    
    var availablePedals: [Pedal] = Pedal.pedalSample()
    
    @Published public var songName: String = ""
    @Published var bandName: String = ""
    @Published var pedalList: [Pedal] = []
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init(delegate: AddSongDelegate? = nil
//         , editSong: Binding<Song?> = .constant(nil)
    ) {
        self.delegate = delegate
//        self._editSong = editSong
    
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
    
    public func shouldBeIndicatedWithLight(for pedal: Pedal) -> Bool {
        return pedalList.contains(pedal)
    }
    
    public func addSongPressed() {
        do {
            let song = Song(name: songName, artist: bandName, pedals: pedalList)
            try delegate?.addSong(song)
            
        } catch {
            if let songError = error as? AddSongError {
                alertMessage = songError.alertDescription
                isPresentingAlert = true
                
            }
        }
    }
    
    public func toggleSelection(for pedal: Pedal) {
        if pedalList.contains(pedal) {
            pedalList.removeAll(where: {$0 == pedal})
        } else {
            pedalList.append(pedal)
        }
    }
}
