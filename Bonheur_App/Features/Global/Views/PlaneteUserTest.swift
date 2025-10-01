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
    
//    var planete :  Planete
    
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
                    // MODIFICATION: Suppression du paramètre selectedPlanet dans l'appel
                    PlanetButton(
                        planet: planetViewModel.planetes[index],
                        // selectedPlanet: $selectedPlanet,  // ❌ SUPPRIMÉ - Plus besoin de passer selectedPlanet
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
                
                // Affichage de la planète sélectionnée (optionnel)
//                if !selectedPlanet.isEmpty && planetsVisible {
//                }
                
                Spacer()
            }
        }
    }
}

// Composant réutilisable pour chaque planète-bouton avec animation
struct PlanetButton: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel

    let planet: Planete
    // MODIFICATION: @Binding var selectedPlanet supprimé - Plus besoin de synchroniser avec la vue parente
    // @Binding var selectedPlanet: Planete  // ❌ SUPPRIMÉ
    @State private var isPressed = false
    @State private var rotationAngle = 0.0
    @State private var currentPosition: CGPoint
    @State private var breathingScale = 1.0 // Animation de respiration
    
    let rocketPosition: CGPoint
    let animationDelay: Double
    let breathingPhaseOffset: Double // Nouveau: décalage de phase pour la respiration
    
    // MODIFICATION: Paramètre selectedPlanet supprimé de l'init
    init(planet: Planete, rocketPosition: CGPoint, animationDelay: Double, breathingPhaseOffset: Double) {
        self.planet = planet
        // self.selectedPlanet = selectedPlanet  // ❌ SUPPRIMÉ
        self.rocketPosition = rocketPosition
        self.animationDelay = animationDelay
        self.breathingPhaseOffset = breathingPhaseOffset
        // Initialise la position actuelle à la position de la fusée
        self._currentPosition = State(initialValue: rocketPosition)
    }
    
    var body: some View {
        Button(action: {
            // MODIFICATION: Ligne selectedPlanet = planet supprimée
            // selectedPlanet = planet  // ❌ SUPPRIMÉ - La navigation se fait directement sans stocker
            handlePlanetTap(planet.nom)
            // Navigation directe vers la vue de destination
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
                    .offset(x: currentPosition.x + planet.circleRelativeOffset.x,
                            y: currentPosition.y + planet.circleRelativeOffset.y)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                
                // Image de la planète - avec bounce synchronisé + respiration
                Image(planet.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .offset(x: currentPosition.x, y: currentPosition.y)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                
                // Titre de la planète - avec bounce synchronisé + respiration
                Text(planet.nom)
                    .font(.custom("SpaceMono-Regular", size: 14))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    .offset(x: currentPosition.x,
                            y: currentPosition.y + max(planet.circleSize.height/2, 75) + 15)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Circle())
        .frame(width: 150, height: 150)
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



//        ZStack {
//            Color.blueDark.edgesIgnoringSafeArea(.all)
//            VStack{
//                ForEach (planetViewModel.planetes, id: \.ID) { planete in
//                    Button {
//                        navigationViewModel.path.append(AppRoute.landing(planete : planete))
//                    }label: {
//                        Image(planete.image)
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .scaledToFit()
//                    }
//                }
//            }
//        }
//    }
//}


#Preview {
    PlaneteUserTest()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
}
