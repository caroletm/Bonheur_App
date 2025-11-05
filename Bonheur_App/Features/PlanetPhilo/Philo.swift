//
//  Untitled.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct PlanetePhiloView : View {
    
    @State private var selectedPhilosophy: Philosophy? = nil
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(CourantPhiloViewModel.self) private var courantPhiloViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Image de fond d'écran qui remplit tout l'écran
                Image("BackgroundPhilo")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack{
                    Button {
                        navigationViewModel.path = NavigationPath()
                    }label:{
                        BoutonFusee(isPressed: false)
                    }
                    
                    Spacer()
                        .frame(width : 200)
                    
                    Button {
                        navigationViewModel.path = NavigationPath()
                        navigationViewModel.path.append(AppRoute.landing(planete: planetePhilo))
                    } label: {
                        BoutonRetour()
                    }
                    Spacer()
                }
                .padding(.horizontal,30)
                .offset(x: 0, y: 750)
                
                Image("CadreOnboarding")
                    .resizable()
                    .frame(width: 350, height: 430)
                    .offset(x: 0, y: 80)
                    .padding()
                
                VStack(spacing: 20) {
                    Text("Découvre les piliers du bonheur")
                        .font(.custom("SpaceMono-Regular", size: 17))
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 0, y: 18)
                        .padding()
                    
                    // Grille de 4 boutons (2x2)
                    VStack(spacing: 15) {
                        // Première ligne : 2 premiers éléments
                        HStack(spacing: 15) {
                            if courantPhiloViewModel.philosophy.count > 0 {
                                PhilosophyButton(philosophy: courantPhiloViewModel.philosophy[0].toEnum())
                            }
                            if courantPhiloViewModel.philosophy.count > 1 {
                                PhilosophyButton(philosophy: courantPhiloViewModel.philosophy[1].toEnum())
                            }
                        }

                        // Deuxième ligne : 2 suivants
                        HStack(spacing: 15) {
                            if courantPhiloViewModel.philosophy.count > 2 {
                                PhilosophyButton(philosophy: courantPhiloViewModel.philosophy[2].toEnum())
                            }
                            if courantPhiloViewModel.philosophy.count > 3 {
                                PhilosophyButton(philosophy: courantPhiloViewModel.philosophy[3].toEnum())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .offset(y: 80)
                
                if courantPhiloViewModel.showPopUp {
                    PhilosophyPopupCard(philosophy: courantPhiloViewModel.selectedPhilosophy ?? .bouddhisme)
                        .offset(y: 100)
                }
            }
            .task {
                await courantPhiloViewModel.fetchCourantPhilosophy()
            }
            .animation(.spring(), value: selectedPhilosophy)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlanetePhiloView()
        .environment(NavigationViewModel())
        .environment(CourantPhiloViewModel())
}
