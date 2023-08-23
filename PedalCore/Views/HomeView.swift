//
//  HomeView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    public init() {
        viewModel = HomeViewModel()
    }
    public var body: some View {
        Button {
            viewModel.addPedal(name: "Test", brand: "Cool Brand", knobs: [:])
        } label: {
            Text("Create pedal")
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
