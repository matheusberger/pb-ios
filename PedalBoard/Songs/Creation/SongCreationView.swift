//
//  SongCreationView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

extension Song.Creation {
    struct View: SwiftUI.View {
        
        @ObservedObject var viewModel: ViewModel

        
        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some SwiftUI.View {
            NavigationView {
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
                                    
                                    Knob.GridView(knobs: $pedal.knobs)
                                    
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
                        Button("Add Song") {
                            viewModel.addSongPressed()
                        }
                    }
                }
                .navigationTitle("Add new song")
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $viewModel.isPresentingSheet) {
                NavigationView {
                    SelectPedalView(alreadyChosenPedals: viewModel.pedalList) { selectedPedals in
                        viewModel.updateSelectedPedals(selectedPedals)
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

struct CreateSongView_Previews: PreviewProvider {
    static var previews: some View {
        Song.Creation.View(viewModel: Song.Creation.ViewModel())
    }
}
