//
//  PedalEditView.swift
//  PedalBoard
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

extension Pedal {
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
                    Section("Name") {
                        TextField("Pedal name:", text: $viewModel.pedalName, prompt: Text("Name your pedal here") )
                    }
                    
                    Section("Brand") {
                        TextField("Pedal brand:", text: $viewModel.brandName, prompt: Text("Name the pedal brand here"))
                    }
                    
                    Section("Knobs") {
                        ForEach(viewModel.knobs, id: \.id) { knob in
                            knobDisplay(knob)
                        }
                        .onDelete(perform: { indexSet in
                            viewModel.removeKnob(at: indexSet)
                        })
                        
                        Button {
                            viewModel.addKnobPressed()
                        } label: {
                            Text("Add knob")
                        }
                    }
                }
                
                footerButtons
            }
            .navigationTitle("New Pedal")
            .alert("Failed to save pedal", isPresented: $viewModel.isPresentingAlert) {
            } message: {
                Text(viewModel.alertMessage)
            }
        }
        
        @ViewBuilder
        private func knobDisplay(_ knob: Knob) -> some View {
            if let index = viewModel.knobs.firstIndex(where: {$0.id == knob.id}) {
                HStack {
                    TextField("Knob name:", text: $viewModel.knobs[index].name, prompt: Text("Name the knob here"))
                        .submitLabel(.return)
                    
                    if viewModel.knobs[index].name.isEmpty {
                        Button {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            viewModel.removeKnob(at: IndexSet(integer: index))
                        } label: {
                            Image(systemName: "xmark.circle")
                                .imageScale(.medium)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
        
        private var footerButtons: some View {
            VStack {
                Button {
                    Task {
                        await viewModel.save()
                    }
                } label: {
                    Text("SAVE PEDAL")
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
    }
}

struct PedalCreationView_Previews: PreviewProvider {
    static var previews: some View {
        Pedal.EditView(viewModel: Pedal.EditViewModel(Pedal.emptyPedal()) { _ in })
    }
}
