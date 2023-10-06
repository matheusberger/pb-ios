//
//  HomeView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI

public struct HomeView: View {

    public init() {
        
    }
    
    public var body: some View {
       
        TabView {
            PedalListView()
                .tabItem {
             Label("PedalBoard", systemImage: "text.word.spacing")
                }
            
            SongsListView()
                .tabItem {
                    Label("Songs", systemImage: "music.note.list")
                }
        }
        
     
    }
}

#Preview {
    HomeView()
}
