//
//  CadreBlanc.swift
//  Bonheur_App
//
//  Created by caroletm on 21/09/2025.
//

import SwiftUI

struct CadreBlanc: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 333, height: 433)
            .background(.ultraThinMaterial.opacity(0.20))
            .cornerRadius(20)
            .overlay(
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 17, height: 17)
                        .offset(x: -80, y: -216)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 17, height: 17)
                        .offset(x: 80, y: 216)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white,lineWidth: 2)
                        .blur(radius: 0)
                    
                }
            )
    }
}

#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        CadreBlanc()
    }
}
