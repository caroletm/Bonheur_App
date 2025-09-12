//
//  CadreMiniVignette.swift
//  Bonheur_App
//
//  Created by caroletm on 12/09/2025.
//

import SwiftUI

struct CadreMiniVignette: View {
    
    var image: ImageResource
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 114, height: 134)
            .background(.ultraThinMaterial.opacity(0.20))
            .cornerRadius(20)
            .overlay(
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 114, height: 134)
                        .cornerRadius(20)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 17, height: 17)
                        .offset(x: 0, y: -68)
                 
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white,lineWidth: 2)
                        .blur(radius: 0)
                }
            )
    }
}

#Preview {
    ZStack {
        Color.blueDark.edgesIgnoringSafeArea(.all)
        CadreMiniVignette(image :.photoVoiture)
    }
}
