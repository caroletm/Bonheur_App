//
//  LoginView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 20/10/2025.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            //
            Image("BackgroundUser2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
               
                Text("HAPPYVERSE")
                    .font(.custom("SpaceMono-Bold", size: 22))
                    .foregroundColor(.black)
                
                // Champs Email et Mot de passe
                VStack(spacing: 15) {
                    TextField("Email", text: $authViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("SpaceMono-Regular", size: 12))
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Mot de passe", text: $authViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("SpaceMono-Regular", size: 12))
                        .padding(.horizontal)
                }
                
                // Bouton Se connecter
                Button {
                    authViewModel.signIn()
                } label: {
                    Text("Se connecter")
                        .font(.custom("Poppins-Bold", size: 18))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.blueDark)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .shadow(radius: 4, y: 2)
                }
                .padding(.top, 20)
                
               
                HStack(spacing: 4) {
                    Text("Pas encore de compte ?")
                        .foregroundColor(.black)
                        .font(.custom("Poppins-Light", size: 14))
                    
                    Button {
                        withAnimation {
                            authViewModel.showLogin = false
                            authViewModel.showSignUp = true
                        }
                    } label: {
                        Text("Inscrivez-vous")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(Color.blueDark)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
