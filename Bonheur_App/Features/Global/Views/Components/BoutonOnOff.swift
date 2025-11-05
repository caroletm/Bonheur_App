//
//  BoutonOnOff.swift
//  Bonheur_App
//
//  Created by caroletm on 05/11/2025.
//

import SwiftUI

struct BoutonOnOff: View {
   
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
     
    func boutononOnOff(width: CGFloat, height: CGFloat) -> some View {
         
         ZStack {
             Circle()
                 .frame(width: width, height: height)
                 .foregroundColor(.greyDarkButton)
             Octagon()
                       .fill(Color.greyLightButton)
                       .frame(width: width-12, height: height-12)
                       .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
             Image(systemName: "power.circle")
                 .resizable()
                 .frame(width: 25, height: 25)
                 .foregroundColor(.red)
         }
     }
     
     var body: some View {
         
         boutononOnOff(width: 50, height: 50 )
     }
 }

 #Preview {
     VStack {
         BoutonOnOff()
     }
 }
