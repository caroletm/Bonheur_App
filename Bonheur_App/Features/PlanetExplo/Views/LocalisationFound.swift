//
//  Localisation.swift
//  Bonheur_App
//
//  Created by caroletm on 12/10/2025.
//

import SwiftUI

struct LocalisationFound : View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    @Environment(MemoryChallengeViewModel.self) private var memoryViewModel
    
    @State var address : String? = nil
    @Binding var closePopup : Bool
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 327, height: 260)
                .cornerRadius(10)
            VStack (spacing : 20){
                
                Text("Localisation trouvée : ")
                
                if let address = address {
                    Text(address)
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                } else {
                    ProgressView("Chargement de l’adresse...")

                }
                
                Text("Utiliser cette localisation ?")
                    .padding()
                HStack {
                    Button {
                        closePopup = false
                        mapViewModel.addressFound = address
                    }label:{
                        BoutonText(text: "Oui", width: 50)
                    }
                    Spacer()
                        .frame(width: 50)
                    Button {
                        closePopup = false
                        
                    }label:{
                        BoutonText(text: "Non", width: 50)
                    }
                }
            }
            .task {
                if let coordinate = mapViewModel.userLocation {
                    address = await mapViewModel.getAddress(from: coordinate)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        LocalisationFound(closePopup: .constant(false))
    }
    .environment(NavigationViewModel())
    .environment(MapViewModel())
    .environment(MemoryChallengeViewModel())
}
