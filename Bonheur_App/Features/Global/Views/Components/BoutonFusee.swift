//
//  BoutonFusée.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct BoutonFusee: View {

   @State var isPressed : Bool
  
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
    
    func boutonFusee(width : CGFloat, height : CGFloat, image : ImageResource, isPressed: Bool) -> some View {
        
        if !isPressed {
            return AnyView (
                ZStack {
                    Circle()
                        .frame(width: width, height: height)
                        .foregroundColor(.greyDarkButton)
                    Octagon()
                        .fill(Color.greyLightButton)
                        .frame(width: width-12, height: height-12)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                    Image(image)
                        .shadow(color: .black, radius: 2)
                }
            )
        } else {
            return AnyView (
                ZStack {
                    Circle()
                        .frame(width: width, height: height)
                        .foregroundColor(.greyDarkButton)
                    
                    Octagon()
                        .fill(Color.greyDarkButton)
                        .frame(width: width-12, height: height-12)
                        .overlay(
                            Octagon()
                                .stroke(Color.greyDarkText.opacity(0.2), lineWidth: 4)
                        )
                        .overlay(
                            Octagon()
                                .stroke(Color.black.opacity(0.6), lineWidth: 3)
                                .blur(radius: 4)
                                .offset(x: -2, y: 2)
                                .mask(Octagon().fill(LinearGradient(
                                    gradient: Gradient(colors: [.black, .gray]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )))
                        )
                    Image(image)
                        .shadow(color: .black, radius: 2)

                }
            )
        }
    }
    
    var body: some View {
        
        boutonFusee(width: 62, height: 62, image : .fuseeSeule, isPressed: isPressed)
    }
}

#Preview {
    VStack {
        BoutonFusee(isPressed: false)
    }
}
