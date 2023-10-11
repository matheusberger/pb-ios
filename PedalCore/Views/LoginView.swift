//
//  LoginView.swift
//  PedalCore
//
//  Created by Lucas Migge on 11/10/23.
//

import SwiftUI
import AuthenticationServices

class LoginViewModel: ObservableObject {
    
    var user: UserApple = UserApple(id: "123456", firstName: "John")
    
    func handSingInWithApple(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            switch auth.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                if let newUser = UserApple(credential: appleIDCredential) {
                    saveUserInfo(userApple: newUser)
                    user = newUser
                } else {
                    
                    user = loadUser(credential: appleIDCredential) ?? UserApple(id: "123456", firstName: "John")
                    
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
            UserDefaults.standard.setValue(userData, forKey: userApple.userId)
            
            print("saved apple user: \(userApple)")
            
        } catch {
            print("failed to save user Info: \(error)")
        }
        
    }
    
    private func loadUser(credential: ASAuthorizationAppleIDCredential) -> UserApple? {
        guard
            let appleUserData = UserDefaults.standard.data(forKey: credential.user),
            let appleUser = try? JSONDecoder().decode(UserApple.self, from: appleUserData)
                
        else {
            print("deu ruim loadar")
            return nil
        }
        
        print("Bem vindo de volta \(appleUser)")
        return appleUser
    }
}


struct LoginView: View {
    var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                viewModel.handSingInWithApple(result)
            }
 
            
        }

    }
}

#Preview {
    LoginView()
}
