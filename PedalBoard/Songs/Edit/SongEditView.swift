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
        @EnvironmentObject private var navigationModel: NavigationModel
        @Environment(\.colorScheme) var colorScheme
        @ObservedObject var viewModel: EditViewModel
        
        init(viewModel: EditViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some View {
            VStack {
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
                            knobGrid($pedal)
                        }
                        .onDelete { indexSet in
                            viewModel.removePedal(at: indexSet)
                        }
                        
                        Button {
                            viewModel.attachPedalPressed()
                        } label: {
                            Text("Attach pedal")
                                .foregroundStyle(Color.accentColor)
                        }
                    } header: {
                        Text("Pedalboard")
                    }
                }
                
                footerButtons
            }
            .navigationTitle("New Song")
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
        
        private var footerButtons: some View {
            VStack {
                Button {
                    Task {
                        await viewModel.save()
                    }
                } label: {
                    Text("SAVE SONG")
                        .fontWeight(.bold)
                        .frame(width: 250,height: 30)
                        .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
                }
                .buttonStyle(.borderedProminent)
                
                Button(role: .destructive) {
                    Task {
                        navigationModel.pop()
                    }
                } label: {
                    Text("cancel")
                        .frame(width: 250,height: 30)
                }
                .buttonStyle(.borderless)
            }
            .padding(.top)
        }
        
        @ViewBuilder
        private func knobGrid(_ pedal: Binding<Pedal>) -> some View {
            VStack(alignment: .leading) {
                Text(pedal.name.wrappedValue)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Pedal.KnobGridView(knobs: pedal.knobs)
            }
            .contextMenu {
                Button(role: .destructive) {
                    viewModel.removePedal(pedal.wrappedValue)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
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
