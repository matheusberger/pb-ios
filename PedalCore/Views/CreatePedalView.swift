//
//  CreatePedalView.swift
//  PedalBoard
//
//  Created by Lucas Migge on 02/10/23.
//

import SwiftUI

struct CreatePedalView: View {

    @State var pedalName: String = ""
    @State var brandName: String = ""
    @State var knobNames: [String] = []
    
    @State var isPresentingAlert: Bool = false
    @State var alertMessage: String = ""
    
    var delegate: AddPedalDelegate?
    
    var body: some View {
        
        Form {
            Section("Name") {
                TextField("Pedal name:", text: $pedalName, prompt: Text("Name your pedal here"))
            }
          
            Section("Brand") {
                TextField("Pedal brand:", text: $brandName, prompt: Text("Name the pedal brand here"))
            }
          
            
            Section("Knobs") {
                VStack {
                    ForEach(Array(knobNames.enumerated()), id: \.offset) { index, element in
                        TextField("Knob name:", text: $knobNames[index], prompt: Text("Name the knob here"))
                    }
                    HStack {
                         Spacer()
                        Button {
                            knobNames.append("")
                        } label: {
                            Text("Add knob")
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                   
                }
            }
            
            Button {
                do {
                    try delegate?.addPedalPressed(name: pedalName, brand: brandName, knobNames: knobNames)
                    
                } catch {
                    if let pedalError = error as? AddPedalError {
                        isPresentingAlert = true
                        switch pedalError {
                        case .missingName:
                           alertMessage = "Please, provide the pedal name"
                        case .missingBrand:
                            alertMessage = "Please, provide a brand of the pedal"
                        case .missingKnobs:
                            alertMessage = "Please, provide a knob name for your pedal"
                        }
                    }
                }
              
            } label: {
                HStack {
                    Spacer()
                    Text("Create pedal")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
        .alert("Failed to save new pedal", isPresented: $isPresentingAlert) {
            
        } message: {
            Text(alertMessage)
        }

    }
    
    
}



struct CreatePedalView_Previews: PreviewProvider {
    static var previews: some View {
      CreatePedalView()
    }
}
