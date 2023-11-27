//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongDetailView: View {
    
    @ObservedObject var viewModel: SongsViewModel
    
    @State var isEditingKnobs: Bool = false
    @State var isEditingMusic: Bool = true
    
    @Binding var song: Song
    
    @State var showingAlert: Bool = false
    
    @State var editingName: String = ""
    @State var editingArtist: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                headerView
                
                pedalListView
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func  editSongPressed() {
        withAnimation {
            isEditingKnobs = false
            isEditingMusic.toggle()
        }
    }
    
    private func editKnobsPressed() {
        isEditingKnobs = false
    }
    
    @ViewBuilder
    private var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Song Info")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button {
                    editSongPressed()
                    
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                }
            }
            .overlay(alignment: .center) {
                if isEditingMusic {
                    Text("Editing Song")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.accentColor)
                }
            }
            
            Divider()
            
            
            VStack {
                TextField("", text: $song.name, prompt: Text("Song name"))
                    .font(.title.weight(.medium))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 5)
                   
                if isEditingMusic {
                    Capsule(style: .continuous)
                        .frame(height: 1)
                        .padding(.horizontal)
                        .foregroundStyle(Color.accentColor)
                    
                }
                
                
                TextField("", text: $song.artist, prompt: Text("Band name"))
                    .font(.headline.weight(.regular))
                    .foregroundStyle(.primary)
                    .padding(5)
                
            }
            .allowsHitTesting(isEditingMusic)
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundStyle(Color.white)
                    .shadow(color: .accentColor, radius: isEditingMusic ? 5 : 0)
            )
        }
    }
    
    private var pedalListView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Pedals")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button {
                    withAnimation {
                        isEditingKnobs.toggle()
                    }
                    
                } label: {
                    Image(systemName: isEditingKnobs ? "lock.open.fill" : "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.accentColor)
                        .disabled(isEditingMusic)
                }
            }
            
            Divider()
            
            VStack {
                if isEditingKnobs {
                    VStack {
                        Text("Editing Mode On")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.accentColor)
                        
                        Text("You can adjust the knob level by draggin")
                            .font(.caption)
                            .foregroundStyle(Color.accentColor)
                    }
                    .padding(.top)
                }
                
                if isEditingMusic {
                    NavigationLink {
                        SelectPedalView(pedalList: $song.pedals)
                    } label: {
                        Text("Change Pedals")
                    }

                }
                
                
                ForEach($song.pedals, id: \.id) { $pedal in
                    VStack(alignment: .leading) {
                        Text(pedal.name)
                            .foregroundStyle(.primary)
                            .font(.headline)
                        
                        Text(pedal.brand)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        if !isEditingMusic {
                            KnobsGridView(knobs: $pedal.knobs)
                                .allowsHitTesting(isEditingKnobs)
                        }
                       
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding()
                }
            }
            .background(
                Rectangle()
                    .cornerRadius(10)
                    .foregroundStyle(Color.white)
                    .shadow(color: .accentColor, radius: isEditingKnobs ? 5 : 0)
            )
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

