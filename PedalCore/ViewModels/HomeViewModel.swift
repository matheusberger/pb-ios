//
//  HomeViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 13/10/23.
//

import Foundation
import AuthenticationServices


class HomeViewModel: ObservableObject {
    
    enum State {
        case login, app
    }
    
    var authManager: AuthManager = AuthManager()
    
    @Published var user: UserApple = UserApple(id: "123456", firstName: "John")
    
    @Published var state: State = .login
    
    func viewDidApper() {
        if let persistedUser: UserApple = authManager.loadPersistedUser() {
            self.user = persistedUser
            self.state = .app
            
        }
    }
    
    func handleAppleIDSingIn(_ result: Result<ASAuthorization, Error>) {
        authManager.handSingInWithApple(result) { user in
            self.user = user
            self.state = .app
           
        }
    }
    

    func logOut() {
        self.state = .login
    }
   
   
  
}


