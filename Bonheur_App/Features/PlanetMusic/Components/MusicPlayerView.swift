//
//  BoutonMusic.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 25/09/2025.
//

import SwiftUI

// Forme en segment d'arc pour le sélecteur
struct ArcSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        
        // Arc extérieur
        path.addArc(center: center,
                   radius: outerRadius,
                   startAngle: startAngle,
                   endAngle: endAngle,
                   clockwise: false)
        
        // Arc intérieur (dans le sens inverse)
        path.addArc(center: center,
                   radius: innerRadius,
                   startAngle: endAngle,
                   endAngle: startAngle,
                   clockwise: true)
        
        path.closeSubpath()
        return path
    }
}

// Modèle pour les données du sélecteur
struct MusicCategory {
    let icon: String
    let title: String
    let color: Color
}

// Composant sélecteur musical
struct MusicSelector: View {
    let category: MusicCategory
    let position: Int // Position du 0 à 5 pour calculer l'angle
    @State private var isSelected = false
    @State private var isPressed = false
    
    private var startAngle: Angle {
        let anglePerSegment = 360.0 / 6.0
        return Angle(degrees: Double(position) * anglePerSegment - 90) // -90 pour commencer en haut
    }
    
    private var endAngle: Angle {
        let anglePerSegment = 360.0 / 6.0
        return Angle(degrees: Double(position + 1) * anglePerSegment - 90)
    }
    
    private var iconPosition: CGPoint {
        let middleAngle = (startAngle.degrees + endAngle.degrees) / 2
        let radius: CGFloat = 100 // Rayon pour positionner l'icône
        let x = cos(middleAngle * .pi / 180) * radius
        let y = sin(middleAngle * .pi / 180) * radius
        return CGPoint(x: x, y: y)
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isSelected.toggle()
            }
        } label: {
            ZStack {
                // Segment d'arc
                ArcSegment(
                    startAngle: startAngle,
                    endAngle: endAngle,
                    innerRadius: 70,
                    outerRadius: 130
                )
                .fill(isSelected ? category.color.opacity(0.8) : Color.greyLightButton)
                .overlay(
                    ArcSegment(
                        startAngle: startAngle,
                        endAngle: endAngle,
                        innerRadius: 70,
                        outerRadius: 130
                    )
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .shadow(
                    color: isSelected ? category.color.opacity(0.4) : .clear,
                    radius: 8,
                    x: 0,
                    y: 0
                )
                
                // Icône et texte
                VStack(spacing: 4) {
                    Image(systemName: category.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(isSelected ? .white : .gray)
                    
                    Text(category.title)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(isSelected ? .white : .gray)
                }
                .offset(x: iconPosition.x, y: iconPosition.y)
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}


struct CircularMusicPlayer: View {
    let categories = [
        MusicCategory(icon: "leaf.fill", title: "Jungle", color: .green),
        MusicCategory(icon: "flame.fill", title: "Feu de camp", color: .orange),
        MusicCategory(icon: "tree.fill", title: "Forêt", color: .green),
        MusicCategory(icon: "water.waves", title: "Océan", color: .blue),
        MusicCategory(icon: "cloud.fill", title: "Nuage", color: .gray),
        MusicCategory(icon: "mountain.2.fill", title: "Montagne", color: .brown)
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
                .ignoresSafeArea()
            
            // Les 6 sélecteurs
            ForEach(0..<6, id: \.self) { index in
                MusicSelector(
                    category: categories[index],
                    position: index
                )
            }
            
            // Votre bouton play au centre
            PlayButtonOctagon()
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    CircularMusicPlayer()
}
