//
//  BoutonsFuseeRetour.swift
//  Bonheur_App
//
//  Created by caroletm on 29/09/2025.
//
import SwiftUI

struct  BoutonsFuseeRetour: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    var planete: Planete
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Button {
                    navigationViewModel.path = NavigationPath()
                    navigationViewModel.path.append(AppRoute.planeteUserTest)
                }label:{
                    BoutonFusee(isPressed: false)
                }
                Spacer()
                    .frame(width: 230)
                Button {
                    navigationViewModel.path.append(AppRoute.landing(planete: planete))
                }label:{
                    BoutonRetour()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ZStack {
        Color.blueDark.edgesIgnoringSafeArea(.all)
        BoutonsFuseeRetour(planete: planeteSouvenirs)
    }
    .environment(NavigationViewModel())
}
