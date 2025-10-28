//
//  SegmentShape.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//

//
//  SegmentShape.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//

import SwiftUI

struct SegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let padding: CGFloat = 7  // Espacement entre les segments
    let innerRadiusRatio: CGFloat = 0.35  // Ratio pour le cercle intérieur (trou au centre)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = rect.width / 2
        let innerRadius = outerRadius * innerRadiusRatio
        
        // Calcul de l'espacement en degrés
        let paddingAngle = (padding / (2 * .pi * outerRadius)) * 360
        
        let adjustedStart = startAngle + Angle(degrees: paddingAngle / 2)
        let adjustedEnd = endAngle - Angle(degrees: paddingAngle / 2)
        
        //Conversion en CGFloat pour éviter l'ambiguïté
        let startRadians = CGFloat(adjustedStart.radians)
        let endRadians = CGFloat(adjustedEnd.radians)
        
      
        let startPoint = CGPoint(
            x: center.x + cos(startRadians) * innerRadius,
            y: center.y + sin(startRadians) * innerRadius
        )
        
        path.move(to: startPoint)
        
        // Arc extérieeur
        path.addArc(center: center,
                    radius: outerRadius,
                    startAngle: adjustedStart,
                    endAngle: adjustedEnd,
                    clockwise: false)
        
        // Point de fin sur le cercle intérieur
        let endInnerPoint = CGPoint(
            x: center.x + cos(endRadians) * innerRadius,
            y: center.y + sin(endRadians) * innerRadius
        )
        
        path.addLine(to: endInnerPoint)
        
        // Arc intérieur (dans l'autre sens)
        path.addArc(center: center,
                    radius: innerRadius,
                    startAngle: adjustedEnd,
                    endAngle: adjustedStart,
                    clockwise: true)
        
        path.closeSubpath()
        return path
    }
}
