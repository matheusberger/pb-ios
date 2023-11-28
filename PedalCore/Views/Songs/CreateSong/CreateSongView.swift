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

    
    init(viewModel: CreateSongViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
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
                                
                                KnobsGridView(knobs: $pedal.knobs)
                                
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
            .navigationTitle("Add new song")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresentingSheet) {
            NavigationView {
                SelectPedalView(alreadyChosenPedals: viewModel.pedalList) { selectedPedals in
                    #warning("reduce coupling. create method for viewModel + tests")
                    viewModel.pedalList = selectedPedals
                }
            }
        }
        .alert("Failed to save pedal", isPresented: $viewModel.isPresentingAlert) {
        } message: {
            Text(viewModel.alertMessage)
        }
        
    }
}

struct CreateSongView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSongView(viewModel: CreateSongViewModel())
    }
}
