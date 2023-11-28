//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: SongsListViewModel
    
    @State var isPresentingSheet: Bool = false
    @State var hasChanges: Bool = false
    @State var isEditingKnobs: Bool = false
    @State var isEditingMusic: Bool = false
    
    @State var song: Song
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                headerView
                
                pedalListView
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $isPresentingSheet) {
            NavigationView {
                SelectPedalView(pedalList: song.pedals) { pedals in
                    song.pedals = pedals
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if hasChanges {
                    Button {
                        viewModel.updateSong(for: song)
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private var isEditing: Bool {
        return isEditingKnobs || isEditingMusic
    }
    
    private func editSongPressed() {
        hasChanges = true
        isEditingKnobs = false
        isEditingMusic.toggle()
        
    }
    
    private func editKnobsPressed() {
        hasChanges = true
        isEditingKnobs.toggle()
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
                    withAnimation {
                        editSongPressed()
                    }
                    
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
                    .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
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
                        editKnobsPressed()
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
                    Button {
                        isPresentingSheet.toggle()
                    } label: {
                        Text("Change Pedals")
                    }
                }
                
                ForEach($song.pedals, id: \.signature) { $pedal in
                    VStack(alignment: .leading) {
                        Text(pedal.name)
                            .foregroundStyle(.primary)
                            .font(.headline)
                        
                        Text(pedal.brand)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        if !isEditingMusic {
                            KnobsGridView(knobs: $pedal.knobs, knobStyle: isEditingKnobs ? .editing : .reference)
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
                    .foregroundStyle(colorScheme == .light ?  Color.white : Color.black)
                    .shadow(color: .accentColor, radius: isEditing ? 5 : 0)
            )
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongDetailView(viewModel: SongsListViewModel(), song: Song.getSample().first!)
        }
    }
}

