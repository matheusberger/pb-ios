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
        List {
            Section {
                PedalFormView(viewModel: viewModel.getPedalFormViewModel())
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
