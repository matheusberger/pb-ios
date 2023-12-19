//
//  SongsView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

public struct SongsListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: SongsListViewModel = SongsListViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .empty:
                    emptyView
                    
                case .content:
                    listView
                }
                
                footerButtonsView
            }
            .navigationTitle("My Songs")
            .sheet(isPresented: $viewModel.isShowingSheet) {
                CreateSongView(viewModel: CreateSongViewModel(delegate: self.viewModel))
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        VStack {
            Spacer()
            
            Text("You haven't add any songs yet")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var listView: some View {
        List(viewModel.songs, id:\.signature) { song in
            NavigationLink {
                SongDetailView(viewModel: SongDetailViewModel(song: song, delegate: self.viewModel))
            } label: {
                SongListRow(song: song)
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
    
    private var footerButtonsView: some View {
        VStack {
            Button {
                viewModel.addSongPressed()
            } label: {
                Text("Create new Song")
                    .fontWeight(.bold)
                    .frame(width: 250,height: 30)
                    .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
                
            }.buttonStyle(.borderedProminent)
            
            Button {
                viewModel.populateSongs()
            } label: {
                Image(systemName: "eyes")
            }
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView()
    }
}