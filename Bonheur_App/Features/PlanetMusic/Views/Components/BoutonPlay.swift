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

struct Octagon: Shape {
    func path(in rect: CGRect) -> Path {
        let sides = 8
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()

        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) - 90
            let x = center.x + CGFloat(cos(angle * .pi / 180)) * radius
            let y = center.y + CGFloat(sin(angle * .pi / 180)) * radius
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}

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
                // ✅ Lueur animée
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
                
                // ✅ Bouton principal
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
