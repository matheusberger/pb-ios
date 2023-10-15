//
//  AuthManager.swift
//  PedalCore
//
//  Created by Lucas Migge on 13/10/23.
//

import Foundation
import AuthenticationServices




class AuthManager {
    
    static var shared: AuthManager = AuthManager()
    
    var delegate: LogoutAuthDelegate?
    
    
    public func logoutCurrentUser() {
        
        UserDefaults.standard.removeObject(forKey: Constants.appleUserKey)
        delegate?.userLogout()
    }
    
    
    public func handSingInWithApple(_ result: Result<ASAuthorization, Error>, handler: @escaping (UserApple) -> Void) {
        switch result {
            
        case .success(let auth):
            
            switch auth.credential {
                
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                if let newUser = UserApple(credential: appleIDCredential) {
                    saveUserInfo(userApple: newUser)
                    handler(newUser)
                    
                } else { print("Caiu no previous User")
                    if let previousUser = loadPreviousUser(credential: appleIDCredential) {
                       
                        saveUserInfo(userApple: previousUser)
                        handler(previousUser)

                    }
                }
                
              
 
            default:
                print(auth.credential)
            }
            
        case .failure(let error):
            print(error)
        }
        
    }
    
    private func saveUserInfo(userApple: UserApple) {
        do {
            let userData = try JSONEncoder().encode(userApple)
            UserDefaults.standard.setValue(userData, forKey: Constants.appleUserKey)
            UserDefaults.standard.setValue(userData, forKey: userApple.userId)
            
            
            
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
    
    
    public func loadPersistedUser() -> UserApple? {
        guard
            let appleUserData = UserDefaults.standard.data(forKey: Constants.appleUserKey),
            let appleUser = try? JSONDecoder().decode(UserApple.self, from: appleUserData)
                
        else {
            
            return nil
        }
        
       
        return appleUser
    }
    
    
}

extension AuthManager {
    struct Constants {
        static var appleUserKey = "appleUserKey"
    }
}
