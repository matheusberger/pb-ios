//
//  HomeView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI

public struct HomeView: View {
<<<<<<< HEAD

    public init() {
        
=======
    @ObservedObject var viewModel: HomeViewModel
    
    
    public init() {
        viewModel = HomeViewModel()
    }
    
    public var body: some View {
        NavigationView {
            List(viewModel.filteredPedals, id: \.id) { pedal in
                PedalRow(pedal: pedal)
                    .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
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
>>>>>>> parent of 8452412 (feature(checkKnobName): adding empty state home view)
    }
    
    public var body: some View {
       
        TabView {
            PedalListView()
                .tabItem {
             Label("PedalBoard", systemImage: "text.word.spacing")
                }
            
            SongsListView()
                .tabItem {
                    Label("Songs", systemImage: "music.note.list")
                }
        }
        
     
    }
}

#Preview {
    HomeView()
}
