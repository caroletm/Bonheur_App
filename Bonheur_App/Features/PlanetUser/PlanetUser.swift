import SwiftUI

struct PlaneteUser: View {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirViewModel
    
    @State private var selectedPlanet: Planete? = nil
    @State private var planetsVisible: Bool = false
    @State private var rocketPressed: Bool = false
    
    // MODAL: État pour contrôler l'affichage de la modal du souvenir
    @State private var showSouvenirPopup: Bool = false
    
    // CHECKLIST: États pour la checklist et sa progression
    @State private var showChecklistPopup: Bool = false
    @State private var checklistItems: [Bool] = [false, false, false] // 3 items non cochés au départ
    
    // Position de la fusée (point de départ des planètes)
    @State var rocketPosition = CGPoint(x: 0, y: 650)
    
    // Calcul du pourcentage de progression basé sur les items cochés
    private var progressPercentage: Double {
        let checkedCount = checklistItems.filter { $0 }.count
        return Double(checkedCount) / Double(checklistItems.count)
    }
    
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
                    }
                    .offset(x: 145, y: 530)
                    .opacity(planetsVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8).delay(1.0), value: planetsVisible)
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
                    VStack(spacing: 0) {
                        //texte de la barre de progression
                        Text("Jauge de bonheur de la semaine ")
                            .font(.custom("SpaceMono-Regular", size: 14))
                            .foregroundColor(.white)
                            .bold()
                        
                        //Jauge de progression de la semaine
                        HStack(spacing: 12) {
                            
                            Gauge(value: progressPercentage, in: 0...1) {
                            }
                            .gaugeStyle(.linearCapacity)
                            .tint(Color("greenLight"))
                            .frame(width: 200, height: 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.greyLightButton)
                            )
                            
                            // Bouton pour ouvrir la checklist
                            Button(action: {
                                showChecklistPopup = true
                            }) {
                                Image("BoutonFleche")
                                    .font(.system(size: 32))
                                    .foregroundColor(.greyLightButton)
                            }
                        }
                        
                        // Compteur de pourcentage numerique
                        Text("\(Int(progressPercentage * 100))%")
                            .font(.custom("SpaceMono-Regular", size: 22))
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    .offset(x: 18, y: 735)
                    .opacity(planetsVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8).delay(1.2), value: planetsVisible)
                }
                
                // Contenu au premier plan contenant le texte avant et aprés avoir appuyé sur le bouton fusée
                VStack {
                    Spacer()
                    
                    Text(planetsVisible ? "Choisis ta destination" : "« On ne trouve pas le bonheur, on le cultive »")
                        .font(.custom("SpaceMono-Regular", size: 20))
                        .foregroundStyle(.white)
                        .padding(.top, planetsVisible ? -380 : 0)
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
                    // NavigationStack: Nécessaire pour afficher la barre de navigation avec le bouton fermer
                    
//                    NavigationStack {
                        SouvenirsDetailsPolaView(souvenir: souvenir, showSouvenirPopup: $showSouvenirPopup)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarTrailing) {
//                                    Button("Fermer") {
//                                        showSouvenirPopup = false
//                                    }
//                                }
//                            }
//                    }
                    
                    .presentationDetents([.medium])
                    // Affiche le petit trait en haut permettant de swiper pour fermer
                    .presentationDragIndicator(.visible)
                    // Arrondi des coins supérieurs de la modal
                    .presentationCornerRadius(30)
                }
            }
            // CHECKLIST: Popup de checklist centré à l'écran
            .overlay {
                if showChecklistPopup {
                    ZStack {
                        // Card de checklist
                        VStack(spacing: 20) {
                            Text("Cette semaine...")
                                .font(.custom("SpaceMono-Regular", size: 24))
                                .foregroundColor(.black)
                            
                            // Textes de la checklist
                            let checklistTexts = [
                                "J'ai relevé 1 défi",
                                "J'ai écouté 1 musique",
                                "J'ai consulté 1 souvenir"
                            ]
                            
                            // Les 3 items de checklist
                            ForEach(0..<3) { index in
                                Button(action: {
                                    withAnimation(.spring(response: 0.3)) {
                                        checklistItems[index].toggle()
                                    }
                                }) {
                                    HStack(spacing: 12) {
                                        
                                        Spacer()
                                        
                                        Text(checklistTexts[index])
                                            .font(.custom("SpaceMono-Regular", size: 16))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Spacer()
                                        
                                        Image(systemName: checklistItems[index] ? "checkmark.circle.fill" : "circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(checklistItems[index] ? Color("greenLight") : .gray)
                                            .frame(width: 24)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                Color("greyDarkButton").opacity(1))
                                            .stroke(Color.greenLight.opacity(1), lineWidth: 2)
                                    )
                                }
                            }
                            
                            // Bouton fermer
                            Button(action: {
                                showChecklistPopup = false
                            }) {
                                Text("Fermer")
                                    .font(.custom("SpaceMono-Regular", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color("greenLight"))
                                            .stroke(Color.greyDarkButton.opacity(1), lineWidth: 2)
                                    )
                            }
                            .padding(.top, 10)
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("greyLightButton"))
                                .stroke(Color("greenLight"), lineWidth: 2)
                        )
                        .frame(width: 320)
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: showChecklistPopup)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PlaneteUser()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}
