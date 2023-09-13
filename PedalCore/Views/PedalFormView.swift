//
//  PedalFormView.swift
//  PedalCore
//
//  Created by Migge on 12/09/23.
//

import SwiftUI

struct PedalFormView: View {
    @ObservedObject var viewModel: PedalFormViewModel
    
    var body: some View {
        TextField("Pedal name:", text: $viewModel.name, prompt: Text("Name your pedal here"))
        TextField("Pedal brand:", text: $viewModel.brand, prompt: Text("Name the pedal brand here"))
        
        VStack {
            ForEach(Array(viewModel.knobNames.enumerated()), id: \.offset) { index, element in
                TextField("Knob name:", text: $viewModel.knobNames[index], prompt: Text("Name the knob here"))
            }
            Button {
                viewModel.knobNames.append("")
            } label: {
                Text("Add knob")
            }
            .buttonStyle(.borderedProminent)
        }
        
        Button {
            viewModel.save()
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

struct PedalFormView_Previews: PreviewProvider {
    static var previews: some View {
        let pedal = Pedal(name: "Big Biga", brand: "MHX", knobs: ["Gain" : 50])
        let viewModel = PedalFormViewModel(pedal: pedal) { newPedal in
            print(newPedal)
        }
        PedalFormView(viewModel: viewModel)
    }
}
