//
//  BarreProgression.swift
//  Bonheur_App
//
//  Created by Larderet on 28/10/2025.
//

import SwiftUI

struct BarrePopUpView: View {
    
    @Binding var showChecklistPopup: Bool
    @Binding var checklistItems: [Bool]
    
    var body: some View {
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
                    "J'ai consulté 1 souvenir",
                    "J'ai crée 1 lieu d'intérêt",
                    "J'ai consulté 1 philosophie"
                ]
                
                // Les 3 items de checklist
                ForEach(0..<5) { index in
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            checklistItems[index].toggle()
                        }
                    }) {
                        HStack(spacing: 12) {
                            
                            Spacer()
                            
                            Text(checklistTexts[index])
                                .font(.custom("SpaceMono-Regular", size: 15))
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
