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
    @State var knobName: String = ""
    
    public init() {
        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        VStack {
            TextField("Pedal name:", text: $pedalName, prompt: Text("Name your pedal here"))
            TextField("Pedal brand:", text: $pedalBrand, prompt: Text("Name the pedal brand here"))
            TextField("Knob name:", text: $knobName, prompt: Text("Name the knob here"))
            
            Button {
                viewModel.addPedal(name: pedalName, brand: pedalBrand, knobs: [knobName:0])
                pedalName = ""
                pedalBrand = ""
                knobName = ""
            } label: {
                Text("Create pedal")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
