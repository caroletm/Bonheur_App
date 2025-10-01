//import SwiftUI
//
//// Structure pour définir les données de chaque planète
//struct Planet {
//    let name: String
//    let displayName: String
//    let imageName: String
//    let position: CGPoint
//    let circleSize: CGSize
//    // offset relatif du cercle par rapport au centre de la planète
//    let circleRelativeOffset: CGPoint
//    // Calculer les offsets originaux pour compatibilité
////    var circleOffset: CGPoint {
////        return CGPoint(x: position.x + circleRelativeOffset.x,
////                      y: position.y + circleRelativeOffset.y)
////    }
//}
//
//struct PlanetUserView: View {
//    // Données des planètes avec cercles parfaitement intégrés
//    let planets = [
//        Planet(name: "Explora", displayName: "Explora", imageName: "PlanetExplora",
//               position: CGPoint(x: -100, y: 120),
//               circleSize: CGSize(width: 138, height: 138),
//               circleRelativeOffset: CGPoint(x: 7, y: -5)), // Décalage relatif au centre de la planète
//        
//        Planet(name: "Missions", displayName: "Missions", imageName: "PlanetMissions",
//               position: CGPoint(x: 120, y: 300),
//               circleSize: CGSize(width: 130, height: 130),
//               circleRelativeOffset: CGPoint(x: 7, y: 2)),
//        
//        Planet(name: "Music", displayName: "Music", imageName: "PlanetMusic",
//               position: CGPoint(x: -100, y: 300),
//               circleSize: CGSize(width: 140, height: 140),
//               circleRelativeOffset: CGPoint(x: 7.5, y: -6)),
//        
//        Planet(name: "Philosophie", displayName: "Philosophie", imageName: "PlanetPhilosophie",
//               position: CGPoint(x: 100, y: 120),
//               circleSize: CGSize(width: 129, height: 129),
//               circleRelativeOffset: CGPoint(x: 4, y: 2)),
//        
//        Planet(name: "Souvenirs", displayName: "Souvenirs", imageName: "PlanetSouvenirs",
//               position: CGPoint(x: 0, y: 440),
//               circleSize: CGSize(width: 140, height: 140),
//               circleRelativeOffset: CGPoint(x: 8, y: -5))
//    ]
//    
//    @State private var selectedPlanet: String = ""
//    @State private var planetsVisible: Bool = false
//    @State private var rocketPressed: Bool = false
//    
//    // Position de la fusée (point de départ des planètes)
//    let rocketPosition = CGPoint(x: 0, y: 650)
//    
//    var body: some View {
//        ZStack(alignment: .top){
//            // Image de fond d'écran qui remplit tout l'écran
//            Image("BackgroundUser")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//            
//            // Génération des planètes-boutons avec animation de sortie de la fusée
//            if planetsVisible {
//                ForEach(planets.indices, id: \.self) { index in
//                    PlanetButton(
//                        planet: planets[index],
//                        selectedPlanet: $selectedPlanet,
//                        rocketPosition: rocketPosition,
//                        animationDelay: Double(index) * 0.2, // Délai progressif pour chaque planète
//                        breathingPhaseOffset: Double(index) * 1.2 // Décalage de phase pour la respiration
//                    )
//                }
//            }
//            
//            //Souvenir du jour (apparaît seulement si les planètes sont visibles)
//            if planetsVisible {
//                Image("SouvenirPola.")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 85, height: 85)
//                    .offset(x: 145, y: 530)
//                    .opacity(planetsVisible ? 1.0 : 0.0)
//                    .animation(.easeInOut(duration: 0.8).delay(1.0), value: planetsVisible)
//            }
//            
//            //Bouton Fusée
//            Button(action: {
//                withAnimation(.easeInOut(duration: 0.3)) {
//                    rocketPressed = true
//                }
//                
//                // Animation de lancement des planètes
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    withAnimation(.easeOut(duration: 1.2)) {
//                        planetsVisible.toggle()
//                    }
//                    
//                    // Reset de l'état de la fusée
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        withAnimation(.easeInOut(duration: 0.2)) {
//                            rocketPressed = false
//                        }
//                    }
//                }
//            }) {
//                BoutonFusee(isPressed: rocketPressed)
//            }
//            .offset(x: 0, y: 650)
//            .scaleEffect(rocketPressed ? 1.1 : 1.0)
//            
//            // Contenu au premier plan
//            VStack {
//                Spacer()
//                
//                Text(planetsVisible ? "Choisis ta destination" : "Appuie sur la fusée")
//                    .font(.custom("SpaceMono-Regular", size: 22))
//                    .foregroundStyle(.white)
//                    .padding(.top, -380)
//                    .animation(.easeInOut(duration: 0.5), value: planetsVisible)
//                
//                // Affichage de la planète sélectionnée (optionnel)
//                if !selectedPlanet.isEmpty && planetsVisible {
//                }
//                
//                Spacer()
//            }
//        }