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
                CreateSongView()
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
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(song.artist)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    
                    ForEach(song.pedals) { pedal in
                        HStack(alignment: .center) {
                            ZStack {
                                Circle()
                                    .scaledToFit()
                                    .frame(width: 10)
                                if song.pedals.last?.id != pedal.id {
                                    Capsule(style: .circular)
                                        .frame(width: 1)
                                        .offset(y: 15)
                                }
                               
                            }
                           
                            Text(pedal.name)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
    
                            Text(pedal.brand)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                    
                }
                .searchable(text: $viewModel.searchText, prompt: "Search a pedal")
            }
            
        }
    }
}
    
    struct SongsView_Previews: PreviewProvider {
        static var previews: some View {
            SongsView()
        }
    }
