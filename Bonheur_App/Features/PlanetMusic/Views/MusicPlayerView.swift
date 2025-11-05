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
            Image(.backgroundMusic)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            CadreBlanc()
                .padding(.top, 120)

    
            MusicSelectorView(viewModel: viewModel)
                .padding(.top, 200)

            VStack {
                Spacer()
                Text("Choisis ton ambiance :")
                    .font(.custom("SpaceMono-Bold", size: 20))
                    .foregroundStyle(.white)
                    .padding(.top, -300)
                Spacer()
            }

            BoutonsFuseeRetour(planete: planeteMusic)
                .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    MusicPlayerView()
        .environment(NavigationViewModel())
}

