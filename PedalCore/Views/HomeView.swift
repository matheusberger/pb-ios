//
//  HomeView.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import SwiftUI
import AuthenticationServices


struct ProfileView: View {
    
    var user: UserApple
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Wellcom to Pedalboard!")
            Text(user.userId)
            Text(user.firstName ?? "Unknown name")
            
        }
    }
}

public struct HomeView: View  {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    public init() {
        
    }
    
    public var body: some View {
        Group {
            switch viewModel.state {
            case .login:
                LoginView(viewModel: viewModel)
                
            case .app:
                TabView {
                    PedalListView(viewModel: PedalListViewModel(user: viewModel.user))
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
        .onAppear {
            viewModel.viewDidApper()
        }
       
        

    }
    
    
    
}


#Preview {
    HomeView()
}
