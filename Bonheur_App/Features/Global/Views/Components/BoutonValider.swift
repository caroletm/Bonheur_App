//
//  BoutonValider.swift
//  Bonheur_App
//
//  Created by caroletm on 12/09/2025.
//

import SwiftUI

struct BoutonValider : View {
    
    @State var isValid : Bool
    
    func boutonValider(width : CGFloat, height : CGFloat, isValid : Bool) -> some View {
        
        if !isValid {
            return AnyView(
                ZStack {
                    Rectangle()
                        .fill(Color.greyDarkButton)
                        .frame(width: width, height: height)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(Color.greyLightButton)
                        .frame(width: width-12, height: height-12)
                        .cornerRadius(3)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    Text("Valider")
                        .font(.custom ("SpaceMono-Bold", size: 14))
                        .foregroundStyle(Color.greyDarkText)
                }
                )
        }else{
            return AnyView(
                ZStack {
                    Rectangle()
                        .fill(Color.greyDarkButton)
                        .frame(width: width, height: height)
                        .cornerRadius(3)
                        .shadow(color: .greenFluo.opacity(0.5), radius: 12)
                    
                    Rectangle()
                        .fill(Color.greyLightButton)
                        .frame(width: width-12, height: height-12)
                        .cornerRadius(3)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    Text("Valider")
                        .font(.custom ("SpaceMono-Bold", size: 14))
                        .foregroundStyle(Color.greenValidate)
                }
            )
        }
    }
    
    var body: some View {
       
        boutonValider(width: 90, height: 42, isValid: isValid)

    }
}

#Preview {
    ZStack {
        Color.blueDark
            .ignoresSafeArea()
        BoutonValider(isValid: true)
    }
}
