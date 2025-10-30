//
//  LandindVIew.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 20/10/2025.
//

import SwiftUI

struct LandingView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @State private var animateButton = false
    
    var body: some View {
        ZStack {
            // Image de fond
            Image("BackgroundUser1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Texte centré
            VStack(spacing: 10) {
                Spacer()
                
                Text("HAPPYVERSE")
                    .font(.custom("SpaceMono-Bold", size: 28))
                    .foregroundColor(.white)
                
                Text("Monte à bord, la fusée du bonheur t’attend !")
                    .font(.custom("SpaceMono-Regular", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            
            // Bouton fusée avec lueur
            VStack {
                Spacer()
                
                HStack {
                    ZStack {
                        // 🌟 Lueur colorée derrière le bouton
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.clear]),
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: 60
                                )
                            )
                            .frame(width: 50, height: 50)
                            .scaleEffect(animateButton ? 1.2 : 1.0) // pulsation
                            .opacity(animateButton ? 0.7 : 0.4)
                            .blur(radius: 10)
                        
                        // Bouton fusée
                        Button(action: {
                            withAnimation {
                                authViewModel.showLanding = false
                                authViewModel.showLogin = true
                                authViewModel.clearError()
                            }
                        }) {
                            Image("fusee2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .scaleEffect(animateButton ? 1.1 : 1.0)
                                .shadow(color: .white.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(.leading, 50)
                    .onAppear {
                        // Animation pulsante infinie
                        withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                            animateButton.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 90)
            }
        }
    }
}

#Preview {
    LandingView()
        .environment(AuthViewModel())
}
