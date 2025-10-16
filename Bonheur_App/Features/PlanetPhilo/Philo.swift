//
//  Untitled.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct PlanetePhiloView : View {
    @State private var selectedPhilosophy: Philosophy? = nil
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Image de fond d'écran qui remplit tout l'écran
                Image("BackgroundPhilo")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                BoutonsFuseeRetour(planete: planetePhilo)
                    .padding()
                
                Image("CadreOnboarding")
                    .resizable()
                    .frame(width: 350, height: 430)
                    .offset(x: 0, y: 80)
                    .padding()
                
                VStack(spacing: 20) {
                    Text("Découvre les piliers du bonheur")
                        .font(.custom("SpaceMono-Regular", size: 17))
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 0, y: 18)
                        .padding()
                    
                    // Grille de 4 boutons (2x2)
                    VStack(spacing: 15) {
                        HStack(spacing: 15) {
                            PhilosophyButton(title: "Épicurisme", philosophy: .epicurisme) {
                                selectedPhilosophy = .epicurisme
                            }
                            
                            PhilosophyButton(title: "Confucianisme", philosophy: .confucianisme) {
                                selectedPhilosophy = .confucianisme
                            }
                        }
                        
                        HStack(spacing: 15) {
                            PhilosophyButton(title: "Bouddhisme", philosophy: .bouddhisme) {
                                selectedPhilosophy = .bouddhisme
                            }
                            
                            PhilosophyButton(title: "Stoïcisme", philosophy: .stoicisme) {
                                selectedPhilosophy = .stoicisme
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .offset(y: 80)
                
                // Popup Card
                if let philosophy = selectedPhilosophy {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            selectedPhilosophy = nil
                        }
                    
                    PhilosophyPopupCard(philosophy: philosophy) {
                        selectedPhilosophy = nil
                    }
                    .transition(.scale.combined(with: .opacity))
                    .offset(y: 100)
                }
            }
            .animation(.spring(), value: selectedPhilosophy)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Enum pour les différents courants philosophiques
enum Philosophy {
    case epicurisme, confucianisme, bouddhisme, stoicisme
    
    var title: String {
        switch self {
        case .epicurisme: return "Épicurisme"
        case .confucianisme: return "Confucianisme"
        case .bouddhisme: return "Bouddhisme"
        case .stoicisme: return "Stoïcisme"
        }
    }
    
    var description: String {
        switch self {
        case .epicurisme:
            return "L'épicurisme enseigne que le bonheur réside dans la recherche du plaisir et l'absence de douleur. Il privilégie les plaisirs simples, l'amitié sincère et la tranquillité de l'esprit. Pour Épicure, le bonheur s'atteint en se libérant des craintes inutiles et en vivant une vie modérée et réfléchie."
            
        case .confucianisme:
            return "Le confucianisme met l'accent sur l'harmonie sociale, le respect des traditions et la cultivation de vertus morales. Le bonheur découle de l'accomplissement de ses devoirs envers la famille et la société, ainsi que du perfectionnement de soi à travers l'éducation et la pratique des rituels."
            
        case .bouddhisme:
            return "Le bouddhisme enseigne que le bonheur véritable s'obtient en se libérant de la souffrance causée par l'attachement et le désir. À travers la méditation et la pratique du Noble Chemin Octuple, on atteint l'éveil et la sérénité intérieure en comprenant la nature impermanente de toutes choses."
            
        case .stoicisme:
            return "Le stoïcisme prône l'acceptation sereine de ce qui ne dépend pas de nous et la maîtrise de nos réactions. Le bonheur réside dans la vertu et la sagesse, en vivant conformément à la raison et à la nature. Les stoïciens cultivent la résilience face aux épreuves de la vie."
        }
    }
}

// Bouton pour chaque philosophie
struct PhilosophyButton: View {
    let title: String
    let philosophy: Philosophy
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("SpaceMono-Regular", size: 18))
                .foregroundColor(.greyDarkText)
                .frame(width: 150, height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.greyLightButton)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                )
        }
    }
}

// Popup Card
struct PhilosophyPopupCard: View {
    let philosophy: Philosophy
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(philosophy.title)
                    .font(.custom("SpaceMono-Regular", size: 22))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            Text(philosophy.description)
                .font(.custom("SpaceMono-Regular", size: 18))
                .foregroundColor(.greyDarkText)
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(25)
        .frame(width: 360, height: 520)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.greyLightButton)
                .overlay(Image("CadreOnboarding").resizable().frame(width: 360, height: 545))
                )
        
        .shadow(radius: 20)
    }
}

#Preview {
    PlanetePhiloView()
        .environment(NavigationViewModel())
}
