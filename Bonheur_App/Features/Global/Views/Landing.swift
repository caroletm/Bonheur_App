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
    
    var isOnboardingPresented : Bool = false
    
    var planete: Planete
    
    @State private var currentIndex: Int = 0
    @State private var rotationAngle = 0.0
    @State private var breathingScale = 1.0
//    @State private var isAnimated = false
    @State private var pulse = false

    
    var body: some View {
        
        let currentPlanete = planetViewModel.planetes[currentIndex]
        
        NavigationView {
            
            ZStack {
                Image(.backgroundDetailPlanet)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack(alignment : .center, spacing: 30) {
                    
                    Text("La planète\n\(currentPlanete.nom)")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
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
                        .offset(x: 10)
                        
                        
                        Button {
                            if isOnboardingPresented {
                                navigationViewModel.path.append(AppRoute.onboarding(planete: currentPlanete))
                            }else{
                                navigationViewModel.path.append(currentPlanete.route)
                            }
                            
                        }label:{
                            
                            ZStack {
                                
                                Image(.cercle)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 290, height: 260)
                                    .rotationEffect(.degrees(rotationAngle))

                                Image(currentPlanete.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 260, height: 240)
                                    .offset(x: 2)
                                    .shadow(
                                        color: Color.white.opacity(pulse ? 0.9 : 0),
                                        radius: pulse ? 30 : 6
                                    )
                                    .scaleEffect(pulse ? 1.02 : 1.0)
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
                        .offset(x: -10)
                    }
                    Text(currentPlanete.description)
                        .font(.custom("SpaceMono-Bold", size: 12))
                        .foregroundStyle(.white)
                        .frame(width : 315, height : 220)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                    
                    Button {
                        navigationViewModel.path = NavigationPath()
                        navigationViewModel.path.append(AppRoute.planeteUserTest)
                    } label: {
                        BoutonRetour()
                    }
                }
            }
            .onAppear {
                if let index = planetViewModel.planetes.firstIndex(where: { $0.ID == planete.ID }) {
                    currentIndex = index
                            // Animation de rotation continue du cercle
                    withAnimation(.linear(duration: 9.0).repeatForever(autoreverses: false).delay(0.0 + 0.5)) {
                        rotationAngle = 360.0
                    }
                    // Animation de respiration
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        breathingScale = 11
                    }
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        pulse.toggle()
                    }
                }
            }
            .padding(.vertical, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LandingPlanet(planete : planeteSouvenirs)
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
}
