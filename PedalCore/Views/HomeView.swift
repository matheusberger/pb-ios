//
//  HomeView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

public struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    public init() {
//        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        
        NavigationView {
            
            VStack {
                Group {
                    switch viewModel.state {
                    case .empty:
                        emptyView
                    case .content:
                        contentView
                    }
                }
                .sheet(isPresented: $viewModel.isShowingSheet) {
                    if let pedal = viewModel.editPedal {
                        CreatePedalView(viewModel: CreatePedalViewModel(delegate: self.viewModel, editPedal: pedal))
                    } else {
                        CreatePedalView(viewModel: CreatePedalViewModel(delegate: self.viewModel))
                    }
                    
                }
                .navigationTitle("Pedal List")
                
                Spacer()
                
                Button {
                    viewModel.addIconPressed()
                } label: {
                    Text("Create new pedal")
                        .fontWeight(.bold)
                        .frame(width: 250,height: 30)
                    
                }.buttonStyle(.borderedProminent)
                
                Button {
                    viewModel.populatePedals()
                } label: {
                    Image(systemName: "eyes")
                }
                
            }
            .padding(.bottom, 20)
            
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
        List(viewModel.filteredPedals, id: \.signature) { pedal in
            PedalRow(pedal: pedal)
            
                .swipeActions(edge: .trailing) {
                    Button {
                        viewModel.editPedalPressed(pedal)
                    } label: {
                        
                        Label("Edit", systemImage: "pencil")
                            .tint(.yellow)
                        
                    }
                    
                    Button(role: .destructive) {
                        viewModel.removePedalPressed(pedal)

                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }

            
        }
        .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
