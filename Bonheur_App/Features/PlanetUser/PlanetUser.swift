import SwiftUI

struct PlaneteUser: View {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirViewModel
    @Environment(CitationViewModel.self) private var citationViewModel // AJOUT
    
    @State private var selectedPlanet: Planete? = nil
    @State private var planetsVisible: Bool = false
    @State private var rocketPressed: Bool = false
    
    //    @State private var citation = CitationViewModelApi()
    
    // MODAL l'affichage de la modal du souvenir
    @State private var showSouvenirPopup: Bool = false
    
    // CHECKLIST: États pour la checklist et sa progression
    @State var showChecklistPopup: Bool = false
    @State var checklistItems: [Bool] = [false, false, false, false, false] // 5 items non cochés au départ
    
    // Position de la fusée (point de départ des planètes)
    @State var rocketPosition = CGPoint(x: 0, y: 650)
    
    // ANIMATION: État pour l'animation du bouton Polaroid
    @State private var isPulsing = false
    
    
    var body: some View {
        
        NavigationView {
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
                
                // MODAL: Bouton Polaroid souvenir du jour qui déclenche l'ouverture de la modal
                if planetsVisible {
                    Button(action: {
                        showSouvenirPopup = true
                    }) {
                        Image("SouvenirPola.")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 85)
                            .scaleEffect(isPulsing ? 1.05 : 1.0)
                            .shadow(color: .white.opacity(isPulsing ? 0.8 : 0.4), radius: isPulsing ? 15 : 8)
                            .shadow(color: .yellow.opacity(isPulsing ? 0.6 : 0.2), radius: isPulsing ? 20 : 10)
                    }
                    .offset(x: 145, y: 530)
                    .opacity(planetsVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8).delay(1.0), value: planetsVisible)
                    .onAppear {
                        // Démarre l'animation de pulsation après l'apparition
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                isPulsing = true
                            }
                        }
                    }
                }
                
                // Bouton Fusée
                Button(action: {
                    // Animation de lancement des planètes
                    withAnimation(.easeInOut(duration: 0.3)) {
                        rocketPressed = true
                    }
                    
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
                .offset(x: 0, y: 640)
                
                // CHECKLIST: Gauge de progression et bouton (visibles seulement si planetsVisible est true)
                if planetsVisible {
                    ProgressBarreView(checklistItems: $checklistItems, showChecklistPopup: $showChecklistPopup)
                        .offset(x: 18, y: 735)
                        .opacity(planetsVisible ? 1.0 : 0.0)
                        .animation(.easeInOut(duration: 0.8).delay(1.2), value: planetsVisible)
                }
                
                // Contenu au premier plan contenant les citations aleatoire avant pression du bouton fusée qui est remplacé par le texte de description
                VStack {
                    Spacer()
                    
                    Text(planetsVisible ? "Choisis ta destination" : citationViewModel.generateRandomCitation()) // MODIFICATION
                        .font(.custom("SpaceMono-Regular", size: 20))
                        .foregroundStyle(.white)
                        .padding(.top, planetsVisible ? -380 : -120)
                        .animation(.easeInOut(duration: 0.5), value: planetsVisible)
                        .allowsHitTesting(false)
                        .padding()
                    
                    Spacer()
                }
            }
            // MODAL: Configuration de la modal plein écran
            // .fullScreenCover affiche la vue en plein écran sans laisser voir l'arrière-plan
            .fullScreenCover(isPresented: $showSouvenirPopup) {
                // Sélection aléatoire d'un souvenir (gestion sécurisée avec if let)
                if let souvenir = souvenirViewModel.souvenirsData.randomElement() {
                    
                        SouvenirsDetailsPolaView(souvenir: souvenir, showSouvenirPopup: $showSouvenirPopup)
                    
                    .presentationDetents([.medium])
                    // Affiche le petit trait en haut permettant de swiper pour fermer
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(30)
                }
            }
            // CHECKLIST: Popup de checklist centré à l'écran
            .overlay {
                if showChecklistPopup {
                    BarrePopUpView(showChecklistPopup: $showChecklistPopup, checklistItems: $checklistItems)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        
        .task { // AJOUT: Charge les citations depuis l'API au lancement de la vue
            await citationViewModel.fetchCitation()
        }
        
        
    }
}

#Preview {
    PlaneteUser()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
        .environment(CitationViewModel()) // AJOUT
}
