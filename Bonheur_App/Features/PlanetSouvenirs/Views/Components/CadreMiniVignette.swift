//
//  CadreMiniVignette.swift
//  Bonheur_App
//
//  Created by caroletm on 12/09/2025.
//

import SwiftUI

struct CadreMiniVignette: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    var souvenir : Souvenir
    var hasPhoto : Bool
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 114, height: 134)
            .background(.ultraThinMaterial.opacity(0.20))
            .cornerRadius(20)
            .overlay(
                ZStack {
                    if hasPhoto {
                        Image(souvenir.photo ?? "photoDog")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 114, height: 134)
                            .cornerRadius(20)
                    }else{
                        Text(souvenir.description)
                            .padding(5)
                            .lineLimit(5)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundStyle(.white)
                            .frame(width: 114, height: 134)

                    }
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
        CadreMiniVignette(souvenir: souvenirs[0], hasPhoto: false)
            .environment(SouvenirsViewModel())
    }
}
