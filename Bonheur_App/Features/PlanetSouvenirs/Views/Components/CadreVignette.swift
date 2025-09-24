//
//  CadreBlanc.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct CadreVignette: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    var image: ImageResource
    var date : Date
    var iconTheme : ImageResource
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 170, height: 200)
            .background(.ultraThinMaterial.opacity(0.20))
            .cornerRadius(20)
            .overlay(
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 200)
                        .cornerRadius(20)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 17, height: 17)
                        .offset(x: -30, y: -99)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 17, height: 17)
                        .offset(x: 30, y: 99)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white,lineWidth: 2)
                        .blur(radius: 0)
                    VStack {
                        HStack {
                            Image(iconTheme)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .padding(0)
                            Spacer()
                        }
                        Spacer()
                        Text(souvenirsViewModel.dateFormatter(date))
                            .foregroundStyle(.white)
                            .font(.custom("SpaceMono-Bold", size: 13))
                            .padding()
                    }
                    
                }
            )
    }
}

#Preview {
    ZStack {
        Color.blueDark.edgesIgnoringSafeArea(.all)
        CadreVignette(image :.photoVoiture, date : Date(), iconTheme: .logoEnergie)
            .environment(SouvenirsViewModel())
    }
}
