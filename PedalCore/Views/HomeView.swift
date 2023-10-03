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
        NavigationView {
            List(viewModel.pedals, id: \.id) { pedal in
                PedalRow(pedal: pedal)
            }
            
            .sheet(isPresented: $viewModel.isShowingSheet) {
                CreatePedalView(delegate: viewModel)
            }
            
            .navigationTitle("Pedal List")
            
            .toolbar {
                
                // testing view
                Button {
                    viewModel.populatePedals()
                } label: {
                    Image(systemName: "eyes")
                }
                
                Button {
                    viewModel.addIconPressed()
                } label: {
                    Image(systemName: "plus")
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
