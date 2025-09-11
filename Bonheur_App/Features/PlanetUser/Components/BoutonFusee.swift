//
//  BoutonFusée.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct BoutonFusee: View {
    
    struct Octagon: Shape {
        func path(in rect: CGRect) -> Path {
            let w = rect.width
            let h = rect.height
            let s = w * (1 - 1 / sqrt(2))
            
            return Path { path in
                path.move(to: CGPoint(x: s, y: 0))
                path.addLine(to: CGPoint(x: w - s, y: 0))
                path.addLine(to: CGPoint(x: w, y: s))
                path.addLine(to: CGPoint(x: w, y: h - s))
                path.addLine(to: CGPoint(x: w - s, y: h))
                path.addLine(to: CGPoint(x: s, y: h))
                path.addLine(to: CGPoint(x: 0, y: h - s))
                path.addLine(to: CGPoint(x: 0, y: s))
                path.closeSubpath()
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: 62, height: 62)
                .foregroundColor(.greyDarkButton)
            Octagon()
                      .fill(Color.greyLightButton)
                      .frame(width: 50, height: 50)
                      .shadow(color: .black, radius: 4, x: 2, y: 2)

        }
    }
}

#Preview {
    BoutonFusee()
}
