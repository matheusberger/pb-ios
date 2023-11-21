//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongDetailView: View {
    
    let song: Song
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                headerView
                
                Divider()
         
                ForEach(song.pedals, id: \.id) { pedal in
                    VStack(alignment: .leading) {
                        Text(pedal.name)
                            .foregroundStyle(.primary)
                            .font(.headline)
                        
                        Text(pedal.brand)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        KnobsGridView(knobs: .constant(pedal.knobs))
                    }
                    .padding(.vertical)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("Edit")
                }

            }
        }
    }
    
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(song.name)
                .font(.largeTitle)
                .foregroundStyle(.primary)
            
            Text(song.artist)
                .font(.headline)
                .foregroundStyle(.secondary)
            
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongDetailView(song: Song.getSample().first!)
        }
        
    }
}

