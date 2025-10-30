//
//  CadreBlanc.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct CadreVignette: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    var souvenir : SouvenirDTO
    var hasPhoto : Bool
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 170, height: 200)
            .background(.ultraThinMaterial.opacity(0.20))
            .cornerRadius(20)
            .overlay(
                ZStack {
                    if hasPhoto {
                        if let image = souvenirsViewModel.loadImage(from: souvenir.photo ?? "photoDog") {
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 200)
                                .cornerRadius(20)
                        }
                    }else{
                        Text(souvenir.description)
                            .padding(5)
                            .lineLimit(5)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundStyle(.white)
                            .frame(width: 170, height: 200)
                         
                    }

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
                            Image(souvenir.theme.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(10)
                                .shadow(color: .white, radius: 10)
                            Spacer()
                        }
                        Spacer()
                        Text(souvenirsViewModel.dateFormatter(souvenir.date))
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
        CadreVignette(souvenir: souvenirs[0], hasPhoto: false)
            .environment(SouvenirsViewModel())
    }
}
