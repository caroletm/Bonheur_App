//
//  PhiloPopUpCard.swift
//  Bonheur_App
//
//  Created by Larderet on 04/11/2025.
//
import SwiftUI

// Popup Card
struct PhilosophyPopupCard: View {
    
    @Environment(CourantPhiloViewModel.self) private var courantPhiloViewModel

    let philosophy: Philosophy
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(philosophy.title)
                    .font(.custom("SpaceMono-Regular", size: 22))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    courantPhiloViewModel.showPopUp.toggle()
                    
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            Text(philosophy.description)
                .font(.custom("SpaceMono-Regular", size: 18))
                .foregroundColor(.greyDarkText)
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(25)
        .frame(width: 360, height: 520)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.greyLightButton)
                .overlay(Image("CadreOnboarding").resizable().frame(width: 360, height: 545))
                )
        
        .shadow(radius: 20)
    }
}

#Preview {
    PhilosophyPopupCard(philosophy:.bouddhisme)
        .environment(CourantPhiloViewModel())
}
