//
//  CreatePedalView.swift
//  PedalBoard
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

extension Pedal.Creation {
    struct View: SwiftUI.View {
        @Environment(\.dismiss) var dismiss
        @ObservedObject var viewModel: Pedal.Creation.ViewModel
        
        init(viewModel: Pedal.Creation.ViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some SwiftUI.View {
            NavigationView {
                List {
                    Section("Name") {
                        TextField("Pedal name:", text: $viewModel.pedalName, prompt: Text("Name your pedal here") )
                    }
                    
                    Section("Brand") {
                        TextField("Pedal brand:", text: $viewModel.brandName, prompt: Text("Name the pedal brand here"))
                    }
                    
                    Section("Knobs") {
                        
                        ForEach(viewModel.knobs, id: \.id) { knob in
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
                        .onDelete(perform: { indexSet in
                            viewModel.removeKnob(at: indexSet)
                        })
                        
                        Button {
                            viewModel.addKnobPressed()
                        } label: {
                            Text("Add knob")
                        }
                        
                    }
                    
                    Button {
                        viewModel.doneButtonPressed()
                        
                    } label: {
                        Text(viewModel.style == .createPedal ?  "Create pedal" : "Update pedal")
                    }
                    
                    
                    if viewModel.style == .editPedal {
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                        
                    }
                }
                .navigationTitle("Add new song")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Failed to save pedal", isPresented: $viewModel.isPresentingAlert) {
                } message: {
                    Text(viewModel.alertMessage)
                }
            }
        }
    }

}

struct PedalCreationView_Previews: PreviewProvider {
    static var previews: some View {
        Pedal.Creation.View(viewModel: Pedal.Creation.ViewModel(editPedal: Pedal.Model.emptyPedal()))
    }
}
