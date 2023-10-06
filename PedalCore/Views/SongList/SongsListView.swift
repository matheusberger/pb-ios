//
//  SongsListView.swift
//  PedalCore
//
//  Created by Lucas Migge on 03/10/23.
//

import SwiftUI

struct SongsListView: View, AddSongDelegate {

    func addSong(name: String, artist: String, pedals: [Pedal]) {
        let newSong = Song(name: name, band: artist, pedals: pedals)
        self.songs.append(newSong)
        isShowingSheet = false
    }
    
    
    @State var songs: [Song] = [
        Song(name: "Paranoid Android",
             band: "Radiohead",
             pedals: [
                Pedal(name: "Shredmaster",
                      brand: "Marshall",
                      knobs: [
                        Knob(parameter: "volume"),
                        Knob(parameter: "gain"),
                        Knob(parameter: "Contuor")
                      ]
                     ),
                Pedal(name: "Small Stone",
                      brand: "Eletro-Harmonix",
                      knobs: [
                        Knob(parameter: "Speed"),
                        Knob(parameter: "Tone")
                      ]
                     )
                
             ]
            ),
        Song(name: "Teddy Picker",
             band: "Arctic Monkeys",
             pedals: [
                Pedal(name: "Proco Rat",
                      brand: "Generic",
                      knobs: [
                        Knob(parameter: "volume"),
                        Knob(parameter: "gain"),
                        Knob(parameter: "Tone")
                      ]
                     )
             ]
            ),
    ]
    
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationView {
           listView
            .navigationTitle("My Songs")
            .sheet(isPresented: $isShowingSheet) {
                CreateSongView(availablePedals: Pedal.getFamousPedals(), delegate: self)
            }
            .toolbar {
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
       
    }
    
    @ViewBuilder
    private var listView: some View {
        List(songs) { song in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text(song.band)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
              
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    Color.accentColor
                }
                .cornerRadius(10)
                
                ForEach(song.pedals) { pedal in
                    
                    PedalRow(pedal: pedal)
                        .padding(.vertical)
                }
                
            }
            
        }
    }
}

#Preview {
    SongsListView()
}
