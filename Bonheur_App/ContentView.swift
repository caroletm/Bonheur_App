//
//  ContentView.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var navigationViewModel = NavigationViewModel()
    @State private var planetViewModel = PlanetViewModel()
    @State private var souvenirsViewModel = SouvenirsViewModel()
    @State private var challengeViewModel = ChallengeViewModel()
    
    var body: some View {
        
        NavigationStack(path: $navigationViewModel.path) {
            
            PlaneteUser()
            
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
                        
                    case .planeteSouvenirs:
                        SouvenirsView()
                        
                    case .souvenirsFiltre:
                        SouvenirsFilterView()
                        
                    case .planeteExplo:
                        PlaneteExploView()
                        
                    case .planeteMusic:
                        MusicPlayerView()
                    
                    case .planetePhilo:
                        PlanetePhiloView()
                        
                    case .planeteMission:
                        MissionView()
                        
                    }
                }
        }
        .environment(navigationViewModel)
        .environment(planetViewModel)
        .environment(souvenirsViewModel)
        .environment(challengeViewModel)
    }
}

#Preview {
    ContentView()
        .environment(NavigationViewModel())
        .environment(PlanetViewModel())
        .environment(SouvenirsViewModel())
        .environment(ChallengeViewModel())
}
