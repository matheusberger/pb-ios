//
//  LoginView.swift
//  PedalCore
//
//  Created by Lucas Migge on 11/10/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 200) {
                VStack(spacing: 50) {
                    Image(systemName: "text.word.spacing")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(.white)
                    
                    Text("Wellcome to Pedalboard")
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.bold))
                    
        
                }
              
                SignInWithAppleButton { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    viewModel.handSingInWithApple(result)
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height: 50)
     
                
            }
            .padding(.horizontal, 50)
        }
     

    }
}

#Preview {
    LoginView(viewModel: HomeViewModel())
}
