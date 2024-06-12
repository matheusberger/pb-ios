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
        @EnvironmentObject private var navigationModel: NavigationModel
        
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
                Button {
                    Task {
                        viewModel.navigateToPedaList()
                    }
                } label: {
                    Image(systemName: "lanyardcard.fill")
                }
            }
            .onAppear {
                Task {
                    viewModel.setNavigationModel(navigationModel)
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
                    viewModel.detailView(song)
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
            NavigationLink(value: viewModel.editViewModel) {
                Text("NEW SONG")
                    .fontWeight(.bold)
                    .frame(width: 250,height: 30)
                    .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Song.ListViewModel(songProvider: PreviewDataProvider(), pedalProvider: PreviewDataProvider())
        NavigationStack {
            Song.ListView(viewModel: viewModel)
        }
    }
}
