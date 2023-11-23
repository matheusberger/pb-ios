//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongDetailView: View {
    
    @ObservedObject var viewModel: SongsViewModel
    @State var isPresentingSheet: Bool = false
    @State var isEditing: Bool = false
    @Binding var song: Song
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                headerView
                
                Divider()
                
                ForEach($song.pedals, id: \.id) { $pedal in
                    VStack(alignment: .leading) {
                        Text(pedal.name)
                            .foregroundStyle(.primary)
                            .font(.headline)
                        
                        Text(pedal.brand)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        KnobsGridView(knobs: $pedal.knobs)
                    }
                    .disabled(!isEditing)
                    .padding(.vertical)
                }
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $isPresentingSheet) {
            CreateSongView(viewModel: CreateSongViewModel(delegate: self.viewModel
//                                                          , editSong: $song
                                                         )
            )
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("Edit")
                }
            }
        }
    }
    
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(song.name)
                .font(.largeTitle)
                .foregroundStyle(.primary)
            
            Text(song.artist)
                .font(.headline)
                .font(.headline)
                .foregroundStyle(.primary)
            
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        isEditing.toggle()
                    }
                } label: {
                    Image(systemName: isEditing ? "lock.open.fill" : "lock.fill")
                }
              
            }
            
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongDetailView(viewModel: SongsViewModel(), song: .constant(Song.getSample().first!))
        }
        
    }
}

