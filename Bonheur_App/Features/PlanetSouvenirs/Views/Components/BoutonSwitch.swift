//
//  BoutonSwitch.swift
//  Bonheur_App
//
//  Created by caroletm on 23/09/2025.
//

import SwiftUI

struct BoutonSwitch: View {
    
    @State var isOn = true
    
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
    
    func boutonSwitch(isOn: Bool) -> some View {
        
        if !isOn {
            return AnyView (
                ZStack {
                    Rectangle()
                        .fill(Color.greyDarkButton)
                        .opacity(0.75)
                        .frame(width: 67, height: 34)
                        .cornerRadius(50)
                    ZStack {
                        Circle()
                            .fill(Color.greyDarkButton)
                            .frame(width: 33, height : 33)
                        
                        Octagon()
                            .fill(Color.greyLightButton)
                            .frame(width: 24, height: 24)
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                    }
                    .offset(x: -15)
                }
            )
        } else {
            return AnyView (
                ZStack {
                    Rectangle()
                        .fill(Color.greenSwitch)
                        .opacity(0.5)
                        .frame(width: 67, height: 34)
                        .cornerRadius(50)
                        .shadow(color: .white, radius: 10)
                    ZStack {
                        Circle()
                            .fill(Color.greyDarkButton)
                            .frame(width: 33, height : 33)
                        
                        Octagon()
                            .fill(Color.greyLightButton)
                            .frame(width: 24, height: 24)
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                    }
                    .offset(x: 15)
                }
            )
        }
    }
    
    
    var body: some View {
        
        boutonSwitch(isOn: isOn)
    }
}

#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        VStack {
            BoutonSwitch(isOn : false)
            BoutonSwitch(isOn : true)
        }
       
        
    }
}
