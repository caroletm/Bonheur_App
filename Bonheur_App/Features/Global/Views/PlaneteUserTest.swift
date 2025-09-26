//
//  PagePlaneteUser.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI

struct PlaneteUserTest: View {
    
    @Environment(PlanetViewModel.self) private var planetViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel

    var body: some View {
        
        
        ZStack {
            Color.blueDark.edgesIgnoringSafeArea(.all)
            VStack{
                ForEach (planetViewModel.planetes, id: \.ID) { planete in
                    Button {
                        navigationViewModel.path.append(AppRoute.landing(planete : planete))
                    }label: {
                        Image(planete.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                    }
                }
            }
        }
    }
}


#Preview {
    PlaneteUserTest()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
}
