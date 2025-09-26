//
//  Landing.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI

struct LandingPlanet: View {

    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel

    var planete: Planete
    
    @State private var currentIndex: Int = 0

    var body: some View {
        
        let currentPlanete = planetViewModel.planetes[currentIndex]

        ZStack {
            Image(.backgroundDetailPlanet)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)

            VStack(spacing: 30) {
                Text("La planète\n\(currentPlanete.nom)")
                    .font(.custom("SpaceMono-Bold", size: 20))
                    .foregroundStyle(.white)

                HStack {
                    Button {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        } else {
                            currentIndex = planetViewModel.planetes.count - 1
                        }
                    } label: {
                        BoutonChevron(image: .chevronLeft)
                    }
                    
                    Button {
                        navigationViewModel.path.append(AppRoute.onboarding(planete: planete))
                        
                    }label:{
                        
                        ZStack {
                            Image(.cercle)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 290, height: 260)
                            Image(currentPlanete.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 290, height: 260)
                                .offset(x: -15, y: 10)
                        }
                    }

                    Button {
                        if currentIndex < planetViewModel.planetes.count - 1 {
                            currentIndex += 1
                        }else{
                            currentIndex = 0
                        }
                    } label: {
                        BoutonChevron(image: .chevronRight)
                    }
                }

                Text(currentPlanete.description)
                    .font(.custom("SpaceMono-Bold", size: 12))
                    .foregroundStyle(.white)

                Button {
                    navigationViewModel.path.removeLast()
//                    navigationViewModel.path = NavigationPath()
//                    navigationViewModel.path.append(AppRoute.planeteUserTest)
                } label: {
                    BoutonRetour()
                }
            }
        }
        .onAppear {
            if let index = planetViewModel.planetes.firstIndex(where: { $0.ID == planete.ID }) {
                currentIndex = index
            }
        }
    }
}


#Preview {
    LandingPlanet(planete : planeteSouvenirs)
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
}
