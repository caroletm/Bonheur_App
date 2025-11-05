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
    @State private var mapViewModel = MapViewModel()
    @State private var authViewModel = AuthViewModel()
    @State private var courantPhiloViewModel = CourantPhiloViewModel()
    
    var body: some View {
        Group {
            // Si l'utilisateur est authentifié -> Application principale
            if authViewModel.isAuthenticated {
                
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
                                ExploView()
                                
                            case .planeteMusic:
                                MusicPlayerView()
                                
                            case .planetePhilo:
                                PlanetePhiloView()
                                
                            case .planeteMission:
                                MissionView()
                                
                            case .missionAccepter(let challenge):
                                MissionCompletedView(challenge: challenge)
                                
                            case .detailSouvenir(souvenir: let souvenir):
                                SouvenirsDetailsView(souvenir: souvenir)
                                
                            case .createMapInsert:
                                CreateMapInsert(dismissModal : .constant(false))
                                
                            case .detailMapPoint(mapPoint: let mapPoint):
                                DetailMapPoint(mapPoint: mapPoint, showDetailPopup: .constant(false))
                                
                            }
                        }
                }
                .environment(navigationViewModel)
                .environment(planetViewModel)
                .environment(souvenirsViewModel)
                .environment(challengeViewModel)
                .environment(mapViewModel)
                .environment(courantPhiloViewModel)
                .environment(authViewModel)

                
                
            }
            else {
                ZStack {
                    if authViewModel.isLoading && authViewModel.showLanding {
                        // Écran de chargement initial
                        ZStack {
                            Color.black.ignoresSafeArea()
                            VStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(1.5)
                                Text("Chargement...")
                                    .foregroundColor(.white)
                                    .padding(.top)
                            }
                        }
                    } else if authViewModel.showLanding {
                        LandingView()
                    } else if authViewModel.showSignUp {
                        SignUpView()
                    } else if authViewModel.showLogin {
                        LoginView()
                    }
                }
                .environment(authViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(NavigationViewModel())
        .environment(PlanetViewModel())
        .environment(SouvenirsViewModel())
        .environment(ChallengeViewModel())
        .environment(MapViewModel())
        .environment(CitationViewModel())
        .environment(CourantPhiloViewModel())
        .environment(AuthViewModel())
}
