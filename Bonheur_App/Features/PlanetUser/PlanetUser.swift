import SwiftUI

struct PlaneteUser: View {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirViewModel
    
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
            
            //bouton Polaroid souvenir du jour (apparaît seulement si les planètes sont visibles)
            if planetsVisible {
                NavigationLink(destination: SouvenirsDetailsView(souvenir: souvenirViewModel.souvenirsData.randomElement()!)) { // Point d'exclamation attention, si rien dans souvenir ATTENTION!
                    Image("SouvenirPola.")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85, height: 85)
                }
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
                BoutonFusee(isPressed: false)
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Circle())
            .frame(width: 100, height: 100)
            .offset(x: 0, y: 650)
            .scaleEffect(rocketPressed ? 1.1 : 1.0)
            
            // Contenu au premier plan contenant le texte avant et aprés avoir appuyé sur le bouton fusée
            VStack {
                Spacer()
                
                Text(planetsVisible ? "Choisis ta destination" : "Appuie sur la fusée")
                    .font(.custom("SpaceMono-Regular", size: 22))
                    .foregroundStyle(.white)
                    .padding(.top, -380)
                    .animation(.easeInOut(duration: 0.5), value: planetsVisible)
                // Pour que la hitbox du texte ne bloque pas les clics
                    .allowsHitTesting(false)
                
                Spacer()
            }
        }
    }
}



#Preview {
    PlaneteUser()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}
