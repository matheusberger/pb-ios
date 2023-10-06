//
//  CreateSongView.swift
//  PedalCore
//
//  Created by Lucas Migge on 04/10/23.
//

import SwiftUI

protocol AddSongDelegate {
    func addSong(name: String, artist: String, pedals: [Pedal])
    
}

struct CreateSongView: View {
    
    var availablePedals: [Pedal]
    
    var delegate: AddSongDelegate?
    
    @State var songName: String = ""
    @State var bandName: String = ""
    @State var pedalList: [Pedal] = []
    
    @State private var selectedPedalIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section("Song Info") {
                    TextField("Song name", text: $songName, prompt: Text("Name of the song"))
                    TextField("Band name", text: $bandName, prompt: Text("ArtistName"))
                    
                }
                
                Section("Pedalboard") {
                    List {
                        NavigationLink {
                            SelectPedalView(pedals: availablePedals) { selectedPedal in
                                pedalList.append(selectedPedal)
                            }
                            
                        } label: {
                            Text("Attach pedal")
                                .foregroundStyle(Color.accentColor)
                        }
                        
                        ForEach(pedalList) { pedal in
                            PedalRow(pedal: pedal)
                        }
                    }
                }
                
                Section("Save") {
                    Button("Add Song") {
                        delegate?.addSong(name: songName, artist: bandName, pedals: pedalList)
                        
                    }
                }
                
                
                
            }
            .navigationTitle("Add new song")
        }
        
    }
}

#Preview {
    CreateSongView(availablePedals: Pedal.getFamousPedals())
}
