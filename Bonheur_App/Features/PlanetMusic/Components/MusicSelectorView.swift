//
//  MusicSelectorView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//


import SwiftUI

struct MusicSelectorView: View {
    @State private var selectedSegment: Int? = nil
    @State private var isPlaying = false
    
    let options = [
        ("Montagne", "MontagneLogo"),
        ("Jungle", "JungleLogo"),
        ("Feu de camp", "FeudecampLogo"),
        ("Forêt", "Foret"),
        ("Océan", "OceanLogo"),
        ("Nuage", "NuageLogo")
    ]
    
    var body: some View {
        ZStack {
            ForEach(0..<options.count, id: \.self) { index in
                let sliceAngle = 360.0 / Double(options.count)
                let start = Angle(degrees: Double(index) * sliceAngle - 90)
                let end = Angle(degrees: Double(index + 1) * sliceAngle - 90)
                
                SegmentButton(
                    label: options[index].0,
                    imageName: options[index].1,
                    startAngle: start,
                    endAngle: end,
                    isSelected: selectedSegment == index
                ) {
                    selectedSegment = index
                    isPlaying = true
                    // playMusic(for: index)
                }
                .frame(width: 250, height: 250)
            }
            
            PlayButtonOctagon(isPlaying: $isPlaying, selectedSegment: $selectedSegment)
        }
    }
}


#Preview {
    MusicSelectorView()
}


