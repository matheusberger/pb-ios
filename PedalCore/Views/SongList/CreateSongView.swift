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
    
    var body: some View {
        NavigationView {
            Form {
                Section("Song Info") {
                    TextField("Song name", text: $songName, prompt: Text("Name of the song"))
                    TextField("Band name", text: $bandName, prompt: Text("ArtistName"))
                    
                }
                
                Section("Pedalboard") {
                    NavigationLink {
                        SelectPedalView(pedals: availablePedals) { selectedPedal in
                            pedalList.append(selectedPedal)
                        }
                        
                    } label: {
                        Text("Attach pedal")
                            .foregroundStyle(Color.accentColor)
                    }
                    
                    knobsView
                    
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
                    KnobView(knob: $knobs[index])
                        .padding()
                }
            }

        }
        
    }
}

#Preview {
    CreateSongView(availablePedals: Pedal.getFamousPedals())
}
