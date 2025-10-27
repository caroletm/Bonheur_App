//
//  Untitled.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//
//
import SwiftUI

struct MusicPlayerView: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            // Image de fond d'ecran
            Image(.backgroundMusic)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
           
            CadreBlanc()
                .padding(.top, 120)
            
            MusicSelectorView(planeteMusic: planeteMusic)
                .padding(.top, 200)

            // Contenu au premier plann
            VStack {
                Spacer()
                
                Text("Choisis ton ambiance :")
                    .font(.custom("SpaceMono-Bold", size: 20))
                    .foregroundStyle(.white)
                    .padding(.top, -300)
                
                Spacer()
            }
            
            BoutonsFuseeRetour(planete: planeteMusic)
                .padding(.bottom, 50)
               
        }
    }
}

#Preview {
    MusicPlayerView()
        .environment(NavigationViewModel())
}

