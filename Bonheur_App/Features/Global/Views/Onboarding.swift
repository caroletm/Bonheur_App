//
//  OnboardingPlanete.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct OnboardingPlanete: View  {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    var planete : Planete

    var body: some View {
        
        ZStack {
    
            Image(.backgroundSouvenirs)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Bienvenue sur \(planete.nom)")
                    .font(.custom("SpaceMono-Bold", size: 20))
                    .foregroundStyle(.white)
                
                Image(planete.iconOnboarding)
                Text("\(planete.onboarding)")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundStyle(.white)
                Button {
                    navigationViewModel.path.append(AppRoute.planeteSouvenirs)
                }label : {
                    BoutonText(text: "OK", width: 45)
                }
                Spacer()
                    .frame(height: 250)
            }
        }
    }
}

#Preview {
    OnboardingPlanete(planete : planeteSouvenirs)
    .environment(PlanetViewModel())
    .environment(NavigationViewModel())
}
