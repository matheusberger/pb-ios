//
//  SongsView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongsView: View {
    
    @StateObject var viewModel: SongsViewModel = SongsViewModel()
    
    
    var body: some View {
        NavigationView {
            
            Group {
                switch viewModel.state {
                case .empty:
                    emptyView
                case .content:
                    listView
                }
            }
            
            .navigationTitle("My Songs")
            .sheet(isPresented: $viewModel.isShowingSheet) {
                CreateSongView(availablePedals: Pedal.pedalSample(), delegate: self.viewModel)
            }
            .toolbar {
                
                // testing view
                Button {
                    viewModel.populateSongs()
                    
                } label: {
                    Image(systemName: "eyes")
                }
                
                Button {
                    viewModel.isShowingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        Text("You haven't add any songs yet")
            .font(.subheadline)
            .foregroundStyle(.secondary)
        
    }
    
    @ViewBuilder
    private var listView: some View {
        List(viewModel.songs) { song in
            SongRow(song: song)
                .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
