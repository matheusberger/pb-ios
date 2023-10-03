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
    
    var delegate: AddPedalDelegate?
    
    var body: some View {
        
        Form {
            TextField("Pedal name:", text: $pedalName, prompt: Text("Name your pedal here"))
            TextField("Pedal brand:", text: $brandName, prompt: Text("Name the pedal brand here"))
            
            VStack {
                ForEach(Array(knobNames.enumerated()), id: \.offset) { index, element in
                    TextField("Knob name:", text: $knobNames[index], prompt: Text("Name the knob here"))
                }
                Button {
                    knobNames.append("")
                } label: {
                    Text("Add knob")
                }
                .buttonStyle(.borderedProminent)
            }
            
            Button {
                delegate?.addPedalPressed(name: pedalName, brand: brandName, knobNames: knobNames)
                pedalName = ""
                brandName = ""
                knobNames = [""]
            } label: {
                HStack {
                    Spacer()
                    Text("Create pedal")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    
}

protocol AddPedalDelegate {
    func addPedalPressed(name: String, brand: String, knobNames: [String])
}

struct CreatePedalView_Previews: PreviewProvider {
    static var previews: some View {
      CreatePedalView()
    }
}
