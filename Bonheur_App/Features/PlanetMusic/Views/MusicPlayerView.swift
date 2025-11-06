//
//  Untitled.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 11/09/2025.
//
import SwiftUI

struct MusicPlayerView: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel

    @State private var viewModel = MusicPlayerViewModel(planeteMusic: planeteMusic)

    var body: some View {
        ZStack(alignment: .top) {
            // Arrière-plan
            Image(.backgroundMusic)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            CadreBlanc()
                .padding(.top, 120)
            
            

            // Sélecteur de musique
            MusicSelectorView(viewModel: viewModel)
                .padding(.top, 200)
            
            //Texte
            VStack {
                       Spacer()
                       Text("Choisis ton ambiance :")
                           .font(.custom("SpaceMono-Bold", size: 20))
                           .foregroundStyle(.white)
                           .padding(.top, -300)
                       Spacer()
                   }
            
            // Boutons en bas : fusée à gauche, retour au centre
            VStack {
                Spacer()
                
                HStack {
                    // Bouton fusée (tout à gauche)
                    Button {
                        navigationViewModel.path = NavigationPath()
                    } label: {
                        BoutonFusee(isPressed: false)
                    }
                    .padding(.leading, 40)
                    
                    Spacer() // espace flexible entre les deux boutons
                    
                    // Bouton retour (tout à droite)
                    Button {
                        navigationViewModel.path = NavigationPath()
                        navigationViewModel.path.append(AppRoute.landing(planete: planeteMission))
                    } label: {
                        BoutonRetour()
                    }
                    .padding(.trailing, 40)
                }
                .padding(.bottom, 40)
            }

         }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    MusicPlayerView()
        .environment(NavigationViewModel())
}


