//
//  PhiloButton.swift
//  Bonheur_App
//
//  Created by Larderet on 04/11/2025.
//
import SwiftUI

// Bouton pour chaque philosophie
struct PhilosophyButton: View {
    let title: String
    let philosophy: Philosophy
    @Binding var showPopUp: Bool
    
    var body: some View {
        Button {
        showPopUp = true
        } label: {
            Text(philosophy.title)
                .font(.custom("SpaceMono-Regular", size: 18))
                .foregroundColor(.greyDarkText)
                .frame(width: 150, height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.greyLightButton)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                )
            
        }
    }
}
    #Preview {
        PhilosophyButton(title: "Bouddhisme", philosophy: .bouddhisme, showPopUp: .constant(false))
    }

