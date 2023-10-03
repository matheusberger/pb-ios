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
            
            Group {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .content:
                    contentView
                }
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

    @ViewBuilder
    private var emptyView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("None pedals registered yet")
                .font(.headline)
            
            Text("You may add new pedals by tapping in the superior button")
                .font(.subheadline)
        }
        .foregroundStyle(.secondary)
        .font(.headline)
    }
    
    @ViewBuilder
    private var contentView: some View {
        List(viewModel.filteredPedals, id: \.id) { pedal in
            PedalRow(pedal: pedal)
                .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
        }
        
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
