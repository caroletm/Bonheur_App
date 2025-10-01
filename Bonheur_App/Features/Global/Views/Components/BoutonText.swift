//
//  BoutonText.swift
//  Bonheur_App
//
//  Created by caroletm on 12/09/2025.
//

import SwiftUI

struct BoutonText: View {
    
    var text : String
    var width : CGFloat
    
    func boutonText(width : CGFloat, height : CGFloat, text: String) -> some View {
        
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
            Text(text)
                .font(.custom ("SpaceMono-Bold", size: 14))
                .foregroundStyle(Color.greyDarkText)
        }
    }
    
    var body: some View {
        
        boutonText(width: width, height: 40, text: text)
        
    }
}

#Preview {
    BoutonText(text : "OK", width : 52)
}
