//
//  CreatePedalView.swift
//  PedalBoard
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

struct CreatePedalView: View {

    @ObservedObject var viewModel: CreatePedalViewModel
    
    init(viewModel: CreatePedalViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        Form {
            Section("Name") {
                TextField("Pedal name:", text: $viewModel.pedalName, prompt: Text("Name your pedal here") )
            }
          
            Section("Brand") {
                TextField("Pedal brand:", text: $viewModel.brandName, prompt: Text("Name the pedal brand here"))
            }
          
            
            Section("Knobs") {
                VStack {
                    ForEach(Array(viewModel.knobNames.enumerated()), id: \.offset) { index, element in
                        TextField("Knob name:", text: $viewModel.knobNames[index], prompt: Text("Name the knob here"))
                    }
                    HStack {
                         Spacer()
                        Button {
                            viewModel.addKnobPressed()
                        } label: {
                            Text("Add knob")
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                   
                }
            }
            
            Button {
                viewModel.addPedalPressed()
                
            } label: {
                HStack {
                    Spacer()
                    Text("Create pedal")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
        .alert("Failed to save new pedal", isPresented: $viewModel.isPresentingAlert) {
            
        } message: {
            Text(viewModel.alertMessage)
        }

    }
    
}



struct CreatePedalView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePedalView(viewModel: CreatePedalViewModel())
    }
}
