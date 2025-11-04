////
////  Untitled.swift
////  Bonheur_App
////
////  Created by caroletm on 11/09/2025.
////
//
//import SwiftUI
//
//struct PlanetePhiloView : View {
//    @State private var selectedPhilosophy: Philosophy? = nil
//    @Environment(NavigationViewModel.self) private var navigationViewModel
//    
//    @State var showPopUp: Bool = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .top) {
//                // Image de fond d'écran qui remplit tout l'écran
//                Image("BackgroundPhilo")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                BoutonsFuseeRetour(planete: planetePhilo)
//                    .padding()
//                
//                Image("CadreOnboarding")
//                    .resizable()
//                    .frame(width: 350, height: 430)
//                    .offset(x: 0, y: 80)
//                    .padding()
//                
//                VStack(spacing: 20) {
//                    Text("Découvre les piliers du bonheur")
//                        .font(.custom("SpaceMono-Regular", size: 17))
//                        .bold()
//                        .foregroundColor(.white)
//                        .offset(x: 0, y: 18)
//                        .padding()
//                    
//                    // Grille de 4 boutons (2x2)
//                    VStack(spacing: 15) {
//                        HStack(spacing: 15) {
//                            PhilosophyButton(title: "Épicurisme", philosophy: .epicurisme, showPopUp: $showPopUp)
//                            
//                            PhilosophyButton(title: "Confucianisme", philosophy: .confucianisme ,showPopUp: $showPopUp)
//                        }
//                        
//                        HStack(spacing: 15) {
//                            PhilosophyButton(title: "Bouddhisme", philosophy: .bouddhisme,showPopUp: $showPopUp)
//                            
//                            PhilosophyButton(title: "Stoïcisme", philosophy: .stoicisme, showPopUp: $showPopUp) 
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .offset(y: 80)
//                
//                // Popup Card
////                if let philosophy = selectedPhilosophy {
////                    Color.black.opacity(0.4)
////                        .ignoresSafeArea()
////                        .onTapGesture {
////                            selectedPhilosophy = nil
////                        }
//                    if showPopUp {
//                        PhilosophyPopupCard(philosophy: <#Philosophy#>, showPopup: <#Binding<Bool>#>)
//                        }
//                        .transition(.scale.combined(with: .opacity))
//                        .offset(y: 100)
//                    
//                }
//            }
//            .animation(.spring(), value: selectedPhilosophy)
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//
//#Preview {
//    PlanetePhiloView()
//        .environment(NavigationViewModel())
//}
