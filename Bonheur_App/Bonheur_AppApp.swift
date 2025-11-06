//
//  Bonheur_AppApp.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

@main
struct Bonheur_AppApp: App {
    
    // Initialisation des ViewModels en tant que @State pour les partager dans toute l'application
    @State private var planetViewModel = PlanetViewModel()
    @State private var navigationViewModel = NavigationViewModel()
    @State private var souvenirViewModel = SouvenirsViewModel()
    @State private var citationViewModel = CitationViewModel()
    @State private var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Injection des ViewModels dans l'environnement SwiftUI
                .environment(planetViewModel)
                .environment(navigationViewModel)
                .environment(souvenirViewModel)
                .environment(citationViewModel)
                .environment(authViewModel)
        }
    }
}
