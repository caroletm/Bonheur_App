//
//  BoutonPlay.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 25/09/2025.
//
//
//  BoutonPlay.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 25/09/2025.
//

import SwiftUI
import AVFoundation


struct PlayButtonOctagon: View {
    @Binding var isPlaying: Bool
    @Binding var selectedSegment: Int?
    var action: () -> Void
    
    @State private var glowAnimation = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }) {
            ZStack {
                if isPlaying {
                    Circle()
                        .fill(Color.pinkMusic.opacity(0.4))
                        .frame(width: 110, height: 110)
                        .blur(radius: 20)
                        .scaleEffect(glowAnimation ? 1.1 : 0.9)
                        .animation(
                            .easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: glowAnimation
                        )
                        .onAppear { glowAnimation = true }
                        .onDisappear { glowAnimation = false }
                }
                
                // Bouton principal
                Circle()
                    .fill(isPlaying ? Color.greyDarkButton : Color.pinkMusic)
                    .frame(width: 80, height: 80)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(color: isPlaying ? Color.pinkMusic.opacity(0.6) : .clear, radius: 10)
                
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .offset(x: isPlaying ? 0 : 2)
            }
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    ZStack {
        PlayButtonOctagon(
            isPlaying: .constant(false),
            selectedSegment: .constant(nil),
            action: {}
        )
    }
}
