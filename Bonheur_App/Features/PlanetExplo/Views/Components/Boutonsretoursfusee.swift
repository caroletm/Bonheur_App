//
//  Boutonsretoursfusee.swift
//  Bonheur_App
//
//  Created by caroletm on 08/10/2025.
//

import SwiftUI

struct BoutonsRetoursFusee: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    navigationViewModel.path = NavigationPath()
//                    navigationViewModel.path.append(AppRoute.planeteUserTest)
                }label:{
                    BoutonFusee(isPressed: false)
                }
                Spacer()
                Button {
                    navigationViewModel.path.removeLast()
                }label:{
                    BoutonRetour()
                }
            }
            .padding()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    BoutonsRetoursFusee()
        .environment(NavigationViewModel())
}
