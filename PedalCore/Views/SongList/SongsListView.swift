//
//  SongsListView.swift
//  PedalCore
//
//  Created by Lucas Migge on 03/10/23.
//

import SwiftUI

struct SongsListView: View {
    
    @ObservedObject var viewModel: SonglistViewModel = SonglistViewModel()
    
    
    var body: some View {
        NavigationView {
           listView
            .navigationTitle("My Songs")
            .sheet(isPresented: $viewModel.isShowingSheet) {
                CreateSongView(availablePedals: Pedal.getFamousPedals(), delegate: viewModel)
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
    private var listView: some View {
        List(viewModel.allSongs) { song in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text(song.band)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
              
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    Color.accentColor
                }
                .cornerRadius(10)
                
                ForEach(song.pedals) { pedal in
                    
                    PedalRow(pedal: pedal)
                        .padding(.vertical)
                }
                
            }
            
        }
    }
}

#Preview {
    SongsListView()
}
