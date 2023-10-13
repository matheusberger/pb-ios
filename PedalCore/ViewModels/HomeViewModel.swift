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
    
    @Published var user: UserApple = UserApple(id: "123456", firstName: "John")

    @Published var state: State = .login
    
    
    func handSingInWithApple(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            switch auth.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                if let newUser = UserApple(credential: appleIDCredential) {
                    saveUserInfo(userApple: newUser)
                    self.user = newUser
                    self.state = .app
                    
                } else {
                 
                    if let previuousUser = loadPreviousUser(credential: appleIDCredential) {
                        self.user = previuousUser
                        self.state = .app
                        
                    }
                    
                    
                }
                
        
            default:
                print(auth.credential)
            }
            
        case .failure(let error):
            print(error)
        }
        
    }
    
    
    func configureRequest(request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email, .fullName]
    }
    
    
    
    private func saveUserInfo(userApple: UserApple) {
        do {
            let userData = try JSONEncoder().encode(userApple)
            UserDefaults.standard.setValue(userData, forKey: Constants.appleUserKey)
            UserDefaults.standard.setValue(userData, forKey: userApple.userId)
            
            print("saved apple user: \(userApple)")
            
        } catch {
            print("failed to save user Info: \(error)")
        }
        
    }
    
    private func loadPreviousUser(credential: ASAuthorizationAppleIDCredential) -> UserApple? {
        
        let userId = credential.user
        
        guard let userData = UserDefaults.standard.data(forKey: userId) else { return nil}
       
        let userApple: UserApple? = try? JSONDecoder().decode(UserApple.self, from: userData)
        
        return userApple
    }
    
    private func loadPersistedUser() -> UserApple? {
        guard
            let appleUserData = UserDefaults.standard.data(forKey: Constants.appleUserKey),
            let appleUser = try? JSONDecoder().decode(UserApple.self, from: appleUserData)
        else {
    
            return nil
        }
        
        return appleUser
    }
    
    
    func viewDidApper() {
        if let persistedUser: UserApple = loadPersistedUser() {
            self.user = persistedUser
            self.state = .app
    
        }
        
    }
  
}

extension HomeViewModel {
    struct Constants {
        static var appleUserKey = "appleUserKey"
    }
}
