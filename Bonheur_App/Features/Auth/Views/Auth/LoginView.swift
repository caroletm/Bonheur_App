//
//  LoginView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 20/10/2025.
//
import SwiftUI

struct LoginView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        @Bindable var viewModel = authViewModel
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
                // Message d'erreur
                                if let errorMessage = authViewModel.errorMessage {
                                    Text(errorMessage)
                                        .font(.custom("SpaceMono-Regular", size: 12))
                                        .foregroundColor(.red)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                
                // Champs Email et Mot de passe
                VStack(spacing: 15) {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("SpaceMono-Regular", size: 12))
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Mot de passe", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("SpaceMono-Regular", size: 12))
                        .padding(.horizontal)
                }
                
                // Bouton Se connecter
                Button {
                    Task {
                                            await authViewModel.signIn()
                                        }
                } label: {
                    if authViewModel.isLoading {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 50)
                                        } else {
                                            Text("Se connecter")
                                                .font(.custom("Poppins-Bold", size: 18))
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(.white)
                                        }
//                    Text("Se connecter")
//                        .font(.custom("Poppins-Bold", size: 18))
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            RoundedRectangle(cornerRadius: 14)
//                                .fill(Color.blueDark)
//                        )
//                        .foregroundColor(.white)
//                        .padding(.horizontal)
//                        .shadow(radius: 4, y: 2)
                }
                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(authViewModel.isLoading ? Color.gray : Color.blueDark)
                                )
                                .padding(.horizontal)
                                .shadow(radius: 4, y: 2)
                                .disabled(authViewModel.isLoading)
                .padding(.top, 20)
                
               
                HStack(spacing: 4) {
                    Text("Pas encore de compte ?")
                        .foregroundColor(.black)
                        .font(.custom("Poppins-Light", size: 14))
                    
                    Button {
                        withAnimation {
                            authViewModel.showLogin = false
                            authViewModel.showSignUp = true
                            authViewModel.clearError()
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
        .onAppear {
                    // Clear les erreurs quand on arrive sur la page
                    authViewModel.clearError()
                }
    }
}

#Preview {
    LoginView()
        .environment(AuthViewModel())
}
