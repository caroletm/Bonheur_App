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
        
        GeometryReader { geometry in
            
            NavigationView {
                ZStack {
                    
                    Image(planete.backgroundPlanete)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                    
                    CadreBlanc()
                        .offset(y : -130)
                    
                    VStack (spacing : 40){
                        Text("Bienvenue sur \(planete.nom)")
                            .font(.custom("SpaceMono-Bold", size: 20))
                            .foregroundStyle(.white)
                        
                        Image(planete.iconOnboarding)
                        Text("\(planete.onboarding)")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(.white)
                            .frame(width : 263, height : 42)
                            .multilineTextAlignment(.center)
                        
                        Button {
                
                            navigationViewModel.path.append(planete.route)
                                
                        }label : {
                            BoutonText(text: "OK", width: 45)
                        }
                        Spacer()
                            .frame(height: 250)
                    }
                    .offset(y: 10)
                    BoutonsFuseeRetour(planete: planete)
                        .offset(y:-20)
                        
                }
             
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    OnboardingPlanete(planete : planeteSouvenirs)
    .environment(PlanetViewModel())
    .environment(NavigationViewModel())
}

