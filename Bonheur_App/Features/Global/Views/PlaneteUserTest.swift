//
//  PagePlaneteUser.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI

struct PlaneteUserTest: View {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    @State private var selectedPlanet: Planete? = nil
    @State private var planetsVisible: Bool = false
    @State private var rocketPressed: Bool = false
    
    // Position de la fusée (point de départ des planètes)
    @State var rocketPosition = CGPoint(x: 0, y: 650)
    
    var body: some View {
        
        ZStack(alignment: .top){
            // Image de fond d'écran qui remplit tout l'écran
            Image("BackgroundUser")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Génération des planètes-boutons avec animation de sortie de la fusée
            if planetsVisible {
                ForEach(planetViewModel.planetes.indices, id: \.self) { index in
                    PlanetButton(
                        planet: planetViewModel.planetes[index],
                        rocketPosition: rocketPosition,
                        animationDelay: Double(index) * 0.2,
                        breathingPhaseOffset: Double(index) * 1.2
                    )
                }
            }
            
            //Souvenir du jour (apparaît seulement si les planètes sont visibles)
            if planetsVisible {
                Image("SouvenirPola.")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 85)
                    .offset(x: 145, y: 530)
                    .opacity(planetsVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8).delay(1.0), value: planetsVisible)
            }
            
            //Bouton Fusée
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    rocketPressed = true
                }
                
                // Animation de lancement des planètes
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 1.2)) {
                        planetsVisible.toggle()
                    }
                    
                    // Reset de l'état de la fusée
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            rocketPressed = false
                        }
                    }
                }
            }) {
                BoutonFusee(isPressed: rocketPressed)
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Circle())
            .frame(width: 100, height: 100)
            .offset(x: 0, y: 650)
            .scaleEffect(rocketPressed ? 1.1 : 1.0)
            
            // Contenu au premier plan
            VStack {
                Spacer()
                
                Text(planetsVisible ? "Choisis ta destination" : "Appuie sur la fusée")
                    .font(.custom("SpaceMono-Regular", size: 22))
                    .foregroundStyle(.white)
                    .padding(.top, -380)
                    .animation(.easeInOut(duration: 0.5), value: planetsVisible)
                    .allowsHitTesting(false) // ✅ Le texte ne bloque pas les clics
                
                Spacer()
            }
        }
    }
}

// Composant réutilisable pour chaque planète-bouton avec animation
struct PlanetButton: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel

    let planet: Planete
    @State private var isPressed = false
    @State private var rotationAngle = 0.0
    @State private var currentPosition: CGPoint
    @State private var breathingScale = 1.0
    
    let rocketPosition: CGPoint
    let animationDelay: Double
    let breathingPhaseOffset: Double
    
    init(planet: Planete, rocketPosition: CGPoint, animationDelay: Double, breathingPhaseOffset: Double) {
        self.planet = planet
        self.rocketPosition = rocketPosition
        self.animationDelay = animationDelay
        self.breathingPhaseOffset = breathingPhaseOffset
        self._currentPosition = State(initialValue: rocketPosition)
    }
    
    var body: some View {
        Button(action: {
            handlePlanetTap(planet.nom)
            navigationViewModel.path = NavigationPath()
            navigationViewModel.path.append(AppRoute.landing(planete: planet))
        }) {
            ZStack {
                // Cercle d'animation rotatif - avec bounce synchronisé + respiration
                Image("cercle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: planet.circleSize.width,
                           height: planet.circleSize.height)
                    .rotationEffect(.degrees(rotationAngle))
                    .offset(x: planet.circleRelativeOffset.x,
                            y: planet.circleRelativeOffset.y) // ✅ Garde seulement l'offset relatif
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    .allowsHitTesting(false) // ✅ Le cercle décoratif ne bloque pas les clics
                
                // Image de la planète - avec bounce synchronisé + respiration
                Image(planet.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    // ✅ Pas d'offset ici, c'est le centre du bouton
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                
                // Titre de la planète - avec bounce synchronisé + respiration
                Text(planet.nom)
                    .font(.custom("SpaceMono-Regular", size: 14))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    .offset(x: 0,
                            y: max(planet.circleSize.height/2, 75) + 15) // ✅ Garde seulement l'offset relatif en Y
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    .allowsHitTesting(false) // ✅ Le texte ne bloque pas les clics
            }
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Circle())
        .frame(width: 150, height: 150)
        .offset(x: currentPosition.x, y: currentPosition.y) // ✅ L'offset de position est au niveau du bouton
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
        .onAppear {
            currentPosition = rocketPosition
            // Animation de voyage de la fusée vers la position finale
            withAnimation(.easeOut(duration: 1.0).delay(animationDelay)) {
                currentPosition = planet.position
            }
            
            // Animation de rotation continue du cercle
            withAnimation(.linear(duration: 9.0).repeatForever(autoreverses: false).delay(animationDelay + 0.5)) {
                rotationAngle = 360.0
            }
            
            // Animation de respiration légère et lente - désynchronisée
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true).delay(animationDelay + 1.0 + breathingPhaseOffset)) {
                breathingScale = 1.03
            }
        }
    }
}

// Fonction pour gérer l'action de chaque planète
func handlePlanetTap(_ planetName: String) {
    print("Planète \(planetName) sélectionnée!")
    
    // Ici ajouter la logique spécifique pour chaque planète
    switch planetName {
    case "Explora":
        // Navigation vers la vue Explora
        break
    case "Missions":
        // Navigation vers la vue Missions
        break
    case "Music":
        // Navigation vers la vue Music
        break
    case "Philosophie":
        // Navigation vers la vue Philosophie
        break
    case "Souvenirs":
        // Navigation vers la vue Souvenirs
        break
    default:
        break
    }
}

#Preview {
    PlaneteUserTest()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
}
