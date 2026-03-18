//
//  LoginView.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        ZStack {
            darkNavy.ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.cyan)
                
                Text("Rick and Morty App")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    TextField("Kullanıcı Adı", text: $viewModel.username)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    SecureField("Şifre", text: $viewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.performLogin()
                }) {
                    Text("Giriş Yap")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    LoginView()
}
