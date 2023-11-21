//
//  CreateSongView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct CreateSongView: View {
    
    @ObservedObject var viewModel: CreateSongViewModel
    @State var isPresentingSheet: Bool = false
    
    init(viewModel: CreateSongViewModel = CreateSongViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Song name", text: $viewModel.songName, prompt: Text("Name of the song"))
                    TextField("Band name", text: $viewModel.bandName, prompt: Text("ArtistName"))
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
                                
                                LazyVGrid(columns: [GridItem(),GridItem()]) {
                                    ForEach($pedal.knobs) { $knobs in
                                        KnobView(knob: $knobs)
                                            .padding()
                                    }
                                }
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
                        self.isPresentingSheet = true
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
        }
        .sheet(isPresented: $isPresentingSheet) {
            SelectPedalView(viewModel: self.viewModel)
        }
        .alert("Failed to save pedal", isPresented: $viewModel.isPresentingAlert) {
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationTitle("Add new song")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateSongView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSongView()
    }
}
