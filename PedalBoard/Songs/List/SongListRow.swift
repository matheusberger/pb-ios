//
//  SongRow.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation
import SwiftUI

extension Song {
    struct ListRow: View {
        let song: Song.Model
        
        var body: some SwiftUI.View {
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
                                    .frame(width: 1, height: 30)
                                    .offset(y: 15)
                            }
                            
                        }
                        .foregroundStyle(Color.accentColor)
                        .frame(height: 25)
                        HStack(alignment: .bottom) {
                            Text(pedal.name)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                            
                            Text(pedal.brand)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        Song.ListRow(song: Song.getSample().first!)
    }
}
