//
//  HomeView.swift
//  PedalCore
//
//  Created by Migge on 22/08/23.
//

import SwiftUI

public struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    public init() {
        // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
    }
    
    public var body: some View {
        
        NavigationView {
            
            VStack (spacing: 7) {
                Group {
                    switch viewModel.state {
                    case .empty:
                        emptyView
                    case .content:
                        contentView
                    }
                }
                .sheet(isPresented: $viewModel.isShowingSheet, onDismiss: {
                    viewModel.sheetDidDismiss()
                }) {
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
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .frame(width: 250,height: 30)
                    
                }
                .buttonStyle(.borderedProminent)
                
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
            Spacer()
            
            Text("None pedals registered yet")
                .font(.headline)
            
            Text("You may add new pedals by tapping in the superior button")
                .font(.subheadline)
            
            Spacer()
        }
        .foregroundStyle(.secondary)
        .font(.headline)
    }
    
    @ViewBuilder
    private var contentView: some View {
        List(viewModel.filteredPedals, id: \.signature) { pedal in
            PedalRow(pedal: pedal)
            
                .contextMenu(menuItems: {
                    Button {
                        viewModel.editPedalPressed(pedal)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        viewModel.removePedalPressed(pedal)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                })
            
                .swipeActions(edge: .trailing) {
                    Button {
                        viewModel.editPedalPressed(pedal)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(Color("ExtraElementsColor"))
                    
                    
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
            .preferredColorScheme(.dark)
    }
}
