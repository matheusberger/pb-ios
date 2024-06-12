//
//  SongCreationView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song {
    struct EditView: View {
        @ObservedObject var viewModel: EditViewModel
        
        init(viewModel: EditViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some View {
            List {
                Section {
                    TextField("Song name", text: $viewModel.songName, prompt: Text("Song name"))
                    TextField("Band name", text: $viewModel.bandName, prompt: Text("Artist name"))
                } header: {
                    Text("Song info")
                } footer: {
                    Text("You song must have a name and a artist")
                }
                
                Section {
                    ForEach($viewModel.pedalList) { $pedal in
                        VStack {
                            VStack(alignment: .leading) {
                                Text(pedal.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Pedal.KnobGridView(knobs: $pedal.knobs)
                                
                            }
                        }
                        .contextMenu(menuItems: {
                            Button(role: .destructive) {
                                viewModel.removePedal(pedal)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        })
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.removePedal(at: indexSet)
                    })
                    
                    Button {
                        viewModel.attachPedalPressed()
                    } label: {
                        Text("Attach pedal")
                            .foregroundStyle(Color.accentColor)
                    }
                    
                } header: {
                    Text("Pedalboard")
                }
                
                Section("Save") {
                    Button("SAVE SONG") {
                        Task {
                            await viewModel.addSongPressed()
                        }
                    }
                }
            }
            .navigationTitle("NEW SONG")
            .sheet(isPresented: $viewModel.isPresentingSheet) {
                NavigationView {
                    withAnimation {
                        viewModel.selectPedalView
                    }
                }
            }
            .alert("Failed to save pedal", isPresented: $viewModel.isPresentingAlert) {
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

struct SongEditView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Song.EditViewModel(availablePedals: Pedal.pedalSample()) { _ in }
        NavigationStack {
            Song.EditView(viewModel: viewModel)
        }
    }
}
