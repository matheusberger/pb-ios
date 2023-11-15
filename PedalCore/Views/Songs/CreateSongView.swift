//
//  CreateSongView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct CreateSongView: View {
 
    var availablePedals: [Pedal]
    
    weak var delegate: AddSongDelegate?
    
    @State var songName: String = ""
    @State var bandName: String = ""
    @State var pedalList: [Pedal] = []
    
    @State private var selectedPedalIndex = 0
    
    @State var isPresentingAlert: Bool = false
    @State var alertMessage: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Song name", text: $songName, prompt: Text("Name of the song"))
                    TextField("Band name", text: $bandName, prompt: Text("ArtistName"))
                } header: {
                    Text("Song info")
                } footer: {
                    Text("You song must have a name and a artist")
                }

                
                Section {
                    
                    ForEach(pedalList) { pedal in
                            PedalRow(pedal: pedal)
                    }
                    
                    NavigationLink {
                        SelectPedalView(pedals: availablePedals) { selectedPedal in
                            pedalList.append(selectedPedal)
                        }
                        
                    } label: {
                        Text("Attach pedal")
                            .foregroundStyle(Color.accentColor)
                    }
                    
            
                } header: {
                    Text("Pedalboard")
                }
                
                Section("Save") {
                    Button("Add Song") {
                        addSongPressed()
                    }
                }
            }
        }
        .navigationTitle("Add new song")
    }
    
    
    
    private func addSongPressed() {
        do {
            try  delegate?.addSong(name: songName, artist: bandName, pedals: pedalList)
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

struct CreateSongView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSongView(availablePedals: Pedal.pedalSample())
    }
}
