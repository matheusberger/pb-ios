//
//  SongsView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

public struct SongsView: View {
    
    @StateObject var viewModel: SongsViewModel = SongsViewModel()
    
    public init() {}
    
    public var body: some View {
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
                CreateSongView(viewModel: CreateSongViewModel(delegate: self.viewModel))
            }
            .toolbar {
                
                // testing view
                Button {
                    viewModel.populateSongs()
                    
                } label: {
                    Image(systemName: "eyes")
                }
                
                Button {
                    viewModel.addSongPressed()
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
            NavigationLink {
                SongDetailView()
            } label: {
                SongRow(song: song)
                    .contextMenu(menuItems: {
                        Button(role: .destructive) {
                            viewModel.deleteSong(song)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    })
                
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteSong(song)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }

        }
        .searchable(text: $viewModel.searchText, prompt: "Search a song or artist")
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
