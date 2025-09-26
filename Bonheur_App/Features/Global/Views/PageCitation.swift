//
//  PageCitation.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI

struct PageCitation: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    var body: some View {
        
        VStack {
            Text("Citation")
                .font(.title)
            Button {
                navigationViewModel.path.append(AppRoute.planeteUserTest)
            }label :{
                BoutonFusee(isPressed: false)
            }
        }
    }
}

#Preview {
    PageCitation()
        .environment(NavigationViewModel())
}
