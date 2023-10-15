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
    
    var authManager: AuthManager
    
    
    @Published var user: UserApple
    
    @Published var state: State
    
    init(authManager: AuthManager = AuthManager.shared,
         user: UserApple = UserApple.dummyUser(),
         state: State = .login) {
        self.authManager = authManager
        self.user = user
        self.state = state
        
        self.authManager.delegate = self
    }
    
    
    var pedalListViewModel: PedalListViewModel {
        let viewModel = PedalListViewModel(user: user)
        return viewModel
    }
    
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

extension HomeViewModel: LogoutAuthDelegate {
    func userLogout() {
        self.state = .login
    }
    
    
}

