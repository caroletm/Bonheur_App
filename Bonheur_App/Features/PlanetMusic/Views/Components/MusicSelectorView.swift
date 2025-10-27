//
//  MusicSelectorView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//
import SwiftUI
import AVFoundation

struct MusicSelectorView: View {
    @State private var selectedSegment: Int? = 0
    @State private var isPlaying = false
    
    let planeteMusic: PlaneteMusic
    
    var body: some View {
        ZStack {
            // Cercle de fond gris foncé
            Circle()
                .fill(Color.greyDarkButton)
                .frame(width: 270, height: 270)  
            
            // Segments
            ForEach(Array(planeteMusic.themes.enumerated()), id: \.element.id) { index, theme in
                let sliceAngle = 360.0 / Double(planeteMusic.themes.count)
                let start = Angle(degrees: Double(index) * sliceAngle - 90)
                let end = Angle(degrees: Double(index + 1) * sliceAngle - 90)
                
                SegmentButton(
                    label: theme.nom,
                    logo: theme.logo,
                    startAngle: start,
                    endAngle: end,
                    isSelected: selectedSegment == index
                ) {
                    handleSegmentTap(index: index, theme: theme)
                }
                .frame(width: 250, height: 250)
            }
            
            // Bouton play au centre
            PlayButtonOctagon(isPlaying: $isPlaying, selectedSegment: $selectedSegment)
        }
    }
    
    private func handleSegmentTap(index: Int, theme: ThemeMusic) {
        let audioManager = AudioPlayerManager.shared
        
        if selectedSegment == index {
            if isPlaying {
                isPlaying = false
                audioManager.stop()
            } else {
                isPlaying = true
                audioManager.play(theme.musique)
            }
        } else {
            selectedSegment = index
            isPlaying = true
            audioManager.play(theme.musique)
        }
    }
}
#Preview {
    MusicSelectorView(planeteMusic: planeteMusic) 
}


