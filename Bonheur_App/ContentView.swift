//
//  ContentView.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var navigationViewModel = NavigationViewModel()
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    var body: some View {
        
        NavigationStack(path: $navigationViewModel.path) {
            
            PageCitation()
            
                .navigationDestination(for: AppRoute.self) { route in
                    
                    switch route {
                        
                    case .pageCitation:
                        PageCitation()
                        
                    case .planeteUserTest:
                        PlaneteUser()
                        
                    case .landing (let planete):
                        LandingPlanet(planete : planete)
                        
                    case .onboarding(let planete):
                        OnboardingPlanete(planete: planete)
                        
                    case .pageSouvenirs:
                        SouvenirsView()
                        
                    case .souvenirsFiltre:
                        SouvenirsFilterView()
                    }
                }
        }
        .environment(navigationViewModel)
        .environment(planetViewModel)
        .environment(souvenirsViewModel)
        
    }
}

#Preview {
    ContentView()
        .environment(NavigationViewModel())
        .environment(PlanetViewModel())
        .environment(SouvenirsViewModel())
}
