//
//  UserApple.swift
//  PedalCore
//
//  Created by Lucas Migge on 11/10/23.
//

import Foundation
import AuthenticationServices

struct UserApple: Codable {
    var userId: String
    var firstName: String?
    var lastName: String?
    var email: String?
    
    init?(credential: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credential.fullName?.givenName,
            let lastName = credential.fullName?.familyName,
            let email = credential.email
        else { return nil }
        
        self.userId = credential.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    init(id: String, firstName: String) {
        self.userId = id
        self.firstName = firstName
    }
    
}
