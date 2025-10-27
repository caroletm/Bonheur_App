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
import SwiftUI
import AVFoundation

struct PlayButtonOctagon: View {
    @Binding var isPlaying: Bool
    @Binding var selectedSegment: Int?
    
    var body: some View {
        Button {
            let audioManager = AudioPlayerManager.shared

            withAnimation(.easeInOut(duration: 0.2)) {
                if isPlaying {
                    isPlaying = false
                    audioManager.stop()
                } else {
                    isPlaying = true
                    if selectedSegment == nil {
                        selectedSegment = 0
                    }
                    if let selected = selectedSegment {
                        let theme = planeteMusic.themes[selected]
                        audioManager.play(theme.musique)
                    }
                }
            }

        } label: {
            ZStack {
                // Cercle rose au lieu d'octogone
                Circle()
                    .fill(Color.pinkMusic)
                    .frame(width: 80, height: 80)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                
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
            selectedSegment: .constant(nil)
        )
    }
}
