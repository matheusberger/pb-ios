//
//  CreateSongView.swift
//  PedalCore
//
//  Created by Lucas Migge on 04/10/23.
//

import SwiftUI



struct CreateSongView: View {
    
    var availablePedals: [Pedal]
    
    var delegate: AddSongDelegate?
    
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
                    NavigationLink {
                        SelectPedalView(pedals: availablePedals) { selectedPedal in
                            pedalList.append(selectedPedal)
                        }
                        
                    } label: {
                        Text("Attach pedal")
                            .foregroundStyle(Color.accentColor)
                    }
                    
                    knobsView
                    
                } header: {
                    Text("Pedalboard")
                } footer: {
                    Text("You can adjust the knob level by dragginh")
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
    
    
    @ViewBuilder
    var knobsView: some View {
        ForEach(pedalList.indices, id: \.self) { pedalIndex in
            VStack(alignment: .leading) {
                Text(pedalList[pedalIndex].name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(pedalList[pedalIndex].brand)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                KnobListView(knobs: $pedalList[pedalIndex].knobs)
                
            }
        }
        
    }
    
    
    struct KnobListView: View {
        @Binding var knobs: [Knob]
        
        var body: some View {
            LazyVGrid(columns: [GridItem(),GridItem()]) {
                ForEach(knobs.indices, id: \.self) { index in
                    KnobView(isGestureEnabled: true, knob: $knobs[index])
                        .padding()
                }
            }
            
        }
        
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

#Preview {
    CreateSongView(availablePedals: Pedal.getFamousPedals())
}
