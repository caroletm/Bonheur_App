//
//  SegmentButton.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//

import SwiftUI
struct SegmentButton: View {
    let label: String
    let imageName: String 
    let startAngle: Angle
    let endAngle: Angle
    let isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            let midAngle = (startAngle.degrees + endAngle.degrees) / 2
            let radius = geo.size.width / 2 * 0.65
            
            Button(action: action) {
                ZStack {
                    // Fond du segment
                    SegmentShape(startAngle: startAngle, endAngle: endAngle)
                        .fill(isSelected ? Color.greyDarkButton : Color.greyLightButton)
                        .overlay(
                            SegmentShape(startAngle: startAngle, endAngle: endAngle)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    
                    // Image + label
                    VStack(spacing: 2) {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20) // ajuste la taille
                        Text(label)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundStyle(.gray)
                            
                        
                    }
                    .position(
                        x: geo.size.width/2 + cos(midAngle * .pi / 180) * radius,
                        y: geo.size.height/2 + sin(midAngle * .pi / 180) * radius
                    )
                }
                .contentShape(SegmentShape(startAngle: startAngle, endAngle: endAngle))
            }
        }
    }
}




#Preview {
    SegmentButton(label: "Label", imageName: "chevron.right", startAngle: .degrees(0), endAngle: .degrees(90), isSelected: true) { }
}
