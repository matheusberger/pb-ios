//
//  HomeView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var pedalName: String = ""
    @State var pedalBrand: String = ""
    @State var knobNames: [String] = [""]
    
    public init() {
        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        List {
            Section {
                createPedalView
            } header: {
                Text("create your pedal below:")
            }
            
            Section {
                listPedalView
            } header: {
                Text("pedal list:")
            }
        }
    }
    
    @ViewBuilder
    private var listPedalView: some View {
        ForEach(viewModel.pedals, id: \.self) { pedal in
            HStack {
                Text(pedal.name)
                Spacer()
                Text(pedal.brand)
                Spacer()
                VStack {
                    ForEach(Array(pedal.knobs.keys), id: \.self) { name in
                        Text(name)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var createPedalView: some View {
        TextField("Pedal name:", text: $pedalName, prompt: Text("Name your pedal here"))
        TextField("Pedal brand:", text: $pedalBrand, prompt: Text("Name the pedal brand here"))
        
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
            viewModel.addPedal(name: pedalName, brand: pedalBrand, knobNames: knobNames)
            pedalName = ""
            pedalBrand = ""
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
