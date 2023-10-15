//
//  ProfileView.swift
//  PedalCore
//
//  Created by Lucas Migge on 14/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    var authManager: AuthManager = AuthManager.shared
    
    var user: UserApple
    
    var body: some View {
        VStack {
            List {
                Text("Wellcom to Pedalboard!")
                Text(user.userId)
                Text(user.firstName)
        
                
            }
            
            Button(role: .destructive) {
                authManager.logoutCurrentUser()
            } label: {
                Text("Logout from current account")
            }
            .buttonStyle(.borderedProminent)
        }
   
    }
}

#Preview {
    ProfileView(user: UserApple.dummyUser())
}
