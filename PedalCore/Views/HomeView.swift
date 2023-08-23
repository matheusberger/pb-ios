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
    
    public init() {
        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        VStack {
            TextField("Pedal name:", text: $pedalName, prompt: Text("Name your pedal here"))
            Button {
                viewModel.addPedal(name: pedalName, brand: "Cool Brand", knobs: [:])
                pedalName = ""
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
