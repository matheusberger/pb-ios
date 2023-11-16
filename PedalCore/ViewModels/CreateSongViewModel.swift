//
//  CreateSongViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

class CreateSongViewModel: ObservableObject {
    
    weak var delegate: AddSongDelegate?
    
    var availablePedals: [Pedal]
    
    @Published public var songName: String = ""
    @Published var bandName: String = ""
    @Published var pedalList: [Pedal] = []
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init(delegate: AddSongDelegate? = nil, availablePedals: [Pedal] = Pedal.pedalSample()) {
        self.delegate = delegate
        self.availablePedals = availablePedals
        
    }
    

    public func removePedal(at index: IndexSet) {
        self.pedalList.remove(atOffsets: index)
    }
    
    public func removePedal(_ pedal: Pedal) {
        self.pedalList = pedalList.filter({ $0.id != pedal.id})
    }
    
    public func addSongPressed() {
        do {
            try delegate?.addSong(name: songName, artist: bandName, pedals: pedalList)
        } catch {
            if let songError = error as? AddSongError {
                isPresentingAlert = true
                switch songError {
                case .missingName:
                    alertMessage = "Please, provide a name for the song"
                    
                case .missingArtist:
                    alertMessage = "Please, provide the artist name"
                }
            }
        }
    }
}
