//
//  Localisation.swift
//  Bonheur_App
//
//  Created by caroletm on 12/10/2025.
//

import SwiftUI

struct LocalisationFound : View {
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 327, height: 260)
                .cornerRadius(10)
            VStack (spacing : 20){
                Text("Localisation trouvée : ")
                Text("adresse")
                    .font(.custom("SpaceMono-Bold", size: 14))
                Text("Utiliser cette localisation ?")
                    .padding()
                HStack {
                    Button {
                        //
                    }label:{
                        BoutonText(text: "Oui", width: 50)
                    }
                    Spacer()
                        .frame(width: 50)
                    Button {
                        //
                    }label:{
                        BoutonText(text: "Non", width: 50)
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        LocalisationFound()
    }
  
}
