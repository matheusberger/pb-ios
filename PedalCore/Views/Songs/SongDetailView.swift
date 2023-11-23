//
//  SongDetailView.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import SwiftUI

struct SongDetailView: View {
    
    @ObservedObject var viewModel: SongsViewModel
    @State var isPresentingSheet: Bool = false
    @State var isEditing: Bool = false
    @Binding var song: Song
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                headerView
                
                Divider()
                
                VStack {
                    ForEach($song.pedals, id: \.id) { $pedal in
                        VStack(alignment: .leading) {
                            Text(pedal.name)
                                .foregroundStyle(.primary)
                                .font(.headline)
                            
                            Text(pedal.brand)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            KnobsGridView(knobs: $pedal.knobs)
                                .allowsHitTesting(isEditing)
                        }
                        .padding()
                        .background(
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundStyle(Color.white)
                                .shadow(color: .accentColor, radius: isEditing ? 5 : 0)
                        )

                        .padding(.vertical)
                        
                    }
                
                }
  
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    
                    Text(song.artist)
                        .font(.headline)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                
               
                
                Spacer()
                
                VStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                          
                    }
                    
                    Button {
                        isEditing.toggle()
                    } label: {
                        Image(systemName: isEditing ? "lock.open.fill" : "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.accentColor)
                            
                    }
                   
                }
                
               
            }
            
            HStack {
                
               
                
                Spacer()
                
                GeometryReader { geo in
                      
                   }
            }
           
           
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongDetailView(viewModel: SongsViewModel(), song: .constant(Song.getSample().first!))
        }
    }
}

