//
//  BoutonPlus.swift
//  Bonheur_App
//
//  Created by caroletm on 12/09/2025.
//

import SwiftUI

struct BoutonPlus: View {
    
    @State private var pulse = true
    
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
    
    func boutonPlus(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            Circle()
                .frame(width: width, height: height)
                .foregroundColor(.greyDarkButton)
            Octagon()
                .fill(Color.greyLightButton)
                .frame(width: width-12, height: height-12)
                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                .shadow(
                    color: Color.greenSwitch.opacity(pulse ? 0.9 : 0),
                    radius: pulse ? 1 : 0
                )
                .scaleEffect(pulse ? 1.02 : 1.0)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(pulse ? Color.greenSwitch : .greyDarkText)
                .shadow(
                    color: Color.greenSwitch.opacity(pulse ? 1 : 0),
                    radius: pulse ? 6 : 0
                )
                .scaleEffect(pulse ? 1.02 : 1.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                pulse.toggle()
            }
        }
    }

     
            
    var body: some View {
    
        boutonPlus(width: 62, height: 62)
        
    }
}

#Preview {
    ZStack {
        Color.blueDark.edgesIgnoringSafeArea(.all)
        BoutonPlus()
    }

    
}
