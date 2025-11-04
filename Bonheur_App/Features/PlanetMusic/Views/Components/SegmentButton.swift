//
//  SegmentButton.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//

import SwiftUI

struct SegmentButton: View {
    let label: String
    let logo: ImageResource
    let startAngle: Angle
    let endAngle: Angle
    let isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            let midAngle = (startAngle.degrees + endAngle.degrees) / 2
            let radius = geo.size.width / 2 * 0.70
            
            Button(action: action) {
                ZStack {
                    // Fond du segment
                    SegmentShape(startAngle: startAngle, endAngle: endAngle)
                        .fill(isSelected ? Color.pinkMusic : Color.greyLightButton)
                        .overlay(
                            SegmentShape(startAngle: startAngle, endAngle: endAngle)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    
                    // Image + label
                    VStack(spacing: 4) {
                        Image(logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(isSelected ? .white : .gray)
                        
                        Text(label)
                            .font(.custom("SpaceMono-Regular", size: 10))
                            .foregroundStyle(isSelected ? .white : .gray)
                    }
                    .position(
                        x: geo.size.width/2 + cos(midAngle * .pi / 180) * radius,
                        y: geo.size.height/2 + sin(midAngle * .pi / 180) * radius
                    )
                }
            }
            .buttonStyle(.plain)
            .contentShape(SegmentShape(startAngle: startAngle, endAngle: endAngle))
        }
    }
}
