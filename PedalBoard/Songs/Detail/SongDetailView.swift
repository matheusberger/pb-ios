//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song {
    struct DetailView: View {
        @Environment(\.colorScheme) var colorScheme
        
        @ObservedObject var viewModel: DetailViewModel
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    headerView
                    
                    pedalListView
                    
                    Spacer()
                }
                .padding()
            }
            .sheet(isPresented: $viewModel.isPresentingSheet) {
                NavigationView {
                    sheetSelectPedalsView
                }
            }
            .alert("Failed to save Song", isPresented: $viewModel.isPresentingAlert) {
            } message: {
                Text(viewModel.alertMessage)
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            
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
                            viewModel.editSongPressed()
                        }
                        
                    } label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        
                    }
                }
                .overlay(alignment: .center) {
                    if viewModel.isInEditingSongMode {
                        Text("Editing Song")
                            .font(.subheadline)
                            .foregroundStyle(Color.accentColor)
                    }
                }
                
                Divider()
                
                VStack {
                    TextField("", text: $viewModel.song.name, prompt: Text("Song name"))
                        .font(.title.weight(.medium))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 5)
                    
                    if viewModel.isInEditingSongMode {
                        Capsule(style: .continuous)
                            .frame(height: 1)
                            .padding(.horizontal)
                            .foregroundStyle(Color.accentColor)
                        
                    }
                    
                    TextField("", text: $viewModel.song.artist, prompt: Text("Band name"))
                        .font(.headline.weight(.regular))
                        .foregroundStyle(.primary)
                        .padding(5)
                    
                }
                .allowsHitTesting(viewModel.isInEditingSongMode)
                .background(
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
                        .shadow(color: viewModel.isInEditingSongMode ? .accentColor: Color.clear, radius: viewModel.isInEditingSongMode ? 5 : 0)
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
                                viewModel.editKnobsPressed()
                            
                        }
                    } label: {
                        Image(systemName: viewModel.isInEditingKnobsMode ? "lock.open.fill" : "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.accentColor)
                            .disabled(viewModel.isInEditingSongMode)
                    }
                }
                
                Divider()
                
                VStack {
                    if viewModel.isInEditingKnobsMode {
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
                    
                    if viewModel.isInEditingSongMode {
                        Button {
                            withAnimation {
                                viewModel.ChangePedalsButtonPressed()
                            }
                            
                        } label: {
                            Text("Change Pedals")
                                .fontWeight(.semibold)
                                .padding()
                        }
                    }
                    
                    ForEach($viewModel.song.pedals, id: \.signature) { $pedal in
                        VStack(alignment: .leading) {
                            Text(pedal.name)
                                .foregroundStyle(.primary)
                                .font(.headline)
                            
                            Text(pedal.brand)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            if !viewModel.isInEditingSongMode {
                                Pedal.KnobGridView(knobs: $pedal.knobs, knobStyle: viewModel.isInEditingKnobsMode ? .editing : .reference)
                                    .allowsHitTesting(viewModel.isInEditingKnobsMode)
                            }
                        }
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .padding()
                    }
                }
                .padding(.bottom, 20)
                .background(
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundStyle(colorScheme == .light ?  Color.white : Color.black)
                        .shadow(color: viewModel.isInEditing ? .accentColor : Color.clear, radius: viewModel.isInEditing ? 5 : 0)
                )
            }
        }
        
        @ViewBuilder
        private var sheetSelectPedalsView: some View {
            withAnimation {
                viewModel.selectPedalView
            }
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let viewModel = Song.DetailViewModel(song: Song.getSample().first!,
                                                 pedalProvider: PreviewDataProvider())
            Song.DetailView(viewModel: viewModel)
        }
    }
}

