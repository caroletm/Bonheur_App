//
//  ProgressBarreView.swift
//  Bonheur_App
//
//  Created by Larderet on 28/10/2025.
//
import SwiftUI



struct ProgressBarreView: View {
    
    @Binding var checklistItems: [Bool]
    @Binding var showChecklistPopup: Bool
    // Calcul du pourcentage de progression basé sur les items cochés
    private var progressPercentage: Double {
        let checkedCount = checklistItems.filter { $0 }.count
        return Double(checkedCount) / Double(checklistItems.count)
    }
    

    var body: some View {
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

    }
}
