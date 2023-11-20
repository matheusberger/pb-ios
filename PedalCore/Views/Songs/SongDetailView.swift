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
                        
                        KnobsGridView(knobs: .constant(pedal.knobs))
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding()
            
            
        }
    }
    
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(song.name)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(song.artist)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(song: Song.getSample().first!)
    }
}

