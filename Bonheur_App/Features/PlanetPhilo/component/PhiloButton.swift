//
//  PhiloButton.swift
//  Bonheur_App
//
//  Created by Larderet on 04/11/2025.
//
import SwiftUI

// Bouton pour chaque philosophie

struct PhilosophyButton: View {
    
    @Environment(CourantPhiloViewModel.self) private var courantPhiloViewModel
    
    var philosophy: Philosophy
    
    var body: some View {
        
        Button {
            courantPhiloViewModel.selectedPhilosophy = philosophy
            courantPhiloViewModel.showPopUp = true
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(Color.greyLightButton)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
                VStack {
                    Image(philosophy.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                    Text(philosophy.title)
                        .font(.custom("SpaceMono-Regular", size: 18))
                        .foregroundColor(.greyDarkText)
                }
            }
        }
    }
}
#Preview {
    PhilosophyButton(philosophy: .bouddhisme)
        .environment(CourantPhiloViewModel())
}

