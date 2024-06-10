//
//  SongListView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song {
    public struct ListView: View {
        @Environment(\.colorScheme) var colorScheme
        @StateObject var viewModel: ListViewModel
        
        public init(viewModel: ListViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
        }
        
        public var body: some View {
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
            .toolbar {
                NavigationLink {
                    Pedal.ListView(viewModel: viewModel.pedalViewModel)
                } label: {
                    Image(systemName: "lanyardcard.fill")
                }
            }
            .sheet(isPresented: $viewModel.isShowingSheet) {
                Song.EditView(viewModel: Song.EditViewModel(delegate: self.viewModel))
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
                    Song.DetailView(viewModel: Song.DetailViewModel(song: song, delegate: self.viewModel))
                } label: {
                    ListRow(song: song)
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
            }
            .padding(.bottom)
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        let persistence = JsonDataService<Song.Model>(fileName: "SongPreview")
        let provider =  LocalDataProvider<Song.Model>(persistence: persistence)
        let viewModel = Song.ListViewModel(songProvider: provider)
        NavigationStack {
            Song.ListView(viewModel: viewModel)
        }
    }
}
