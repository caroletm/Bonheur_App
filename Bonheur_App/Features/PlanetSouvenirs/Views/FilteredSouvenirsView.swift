//
//  FilteredSouvenirsView.swift
//  Bonheur_App
//
//  Created by caroletm on 01/10/2025.
//

import SwiftUI

struct FilteredSouvenirsView: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        
        VStack (alignment : .leading) {
            
            Text(souvenirsViewModel.dateEnString())
                .font(.custom("SpaceMono-Bold", size: 20))
                .foregroundStyle(.white)
                .padding()
            
            if !souvenirsViewModel.filteredSouvenirs.isEmpty {

                LazyVGrid(columns: columns) {
                    ForEach(souvenirsViewModel.filteredSouvenirs, id: \.id) { souvenir in
                        CadreMiniVignette(image: souvenir.photo ?? .photoDog)
                    }
                }
            } else {
                Text("Vous n'avez pas de souvenirs correspondant à vos critères")
                    .font(.custom("Poppins-Regular", size: 16))
                    .frame (width : 340)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding()
            }
            Spacer()
        }
        .padding(.top, 60)
    }
}

#Preview {
    ZStack {
        Image(.backgroundSouvenirs)
            .ignoresSafeArea(edges: .all)
        FilteredSouvenirsView()
            .environment(SouvenirsViewModel())
    }
}

