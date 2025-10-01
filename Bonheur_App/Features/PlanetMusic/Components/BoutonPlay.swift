//
//  BoutonPlay.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 25/09/2025.
//

import SwiftUI

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
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                if isPlaying {
                    // Arrêt → désélection et pause musique
                    isPlaying = false
                    selectedSegment = nil
                    // stopMusic()
                } else {
                    // Lecture → si aucun segment choisi, sélectionner le premier
                    isPlaying = true
                    if selectedSegment == nil {
                        selectedSegment = 0
                        // playMusic(for: 0)
                    }
                }
            }
        } label: {
            ZStack {
                Octagon()
                    .fill(isPlaying ? Color.greyDarkButton : Color.greyLightButton)
                    .frame(width: 120, height: 120)
                    .overlay(Octagon().stroke(Color.white, lineWidth: 3))
                
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.pinkMusic)
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
