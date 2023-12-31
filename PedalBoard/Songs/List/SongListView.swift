//
//  SongsView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI
import PedalCore

extension Song.List {
    public struct View: SwiftUI.View {
        @Environment(\.colorScheme) var colorScheme
        @StateObject var viewModel: ViewModel
        
        public init(viewModel: ViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
        }
        
        public var body: some SwiftUI.View {
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
                .toolbar {
                    NavigationLink {
                        Pedal.List.View(viewModel: viewModel.pedalViewModel)
                    } label: {
                        Image(systemName: "lanyardcard.fill")
                    }
                }
                .sheet(isPresented: $viewModel.isShowingSheet) {
                    Song.Creation.View(viewModel: Song.Creation.ViewModel(delegate: self.viewModel))
                }
            }
        }
        
        @ViewBuilder
        private var emptyView: some SwiftUI.View {
            VStack {
                Spacer()
                
                Text("You haven't add any songs yet")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        
        @ViewBuilder
        private var listView: some SwiftUI.View {
            List(viewModel.songs, id:\.signature) { song in
                NavigationLink {
                    Song.Details.View(viewModel: Song.Details.ViewModel(song: song, delegate: self.viewModel))
                } label: {
                    Row(song: song)
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
        
        private var footerButtonsView: some SwiftUI.View {
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
        let viewModel = Song.List.ViewModel(songProvider: provider)
        Song.List.View(viewModel: viewModel)
    }
}
