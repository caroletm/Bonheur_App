//
//  FilteredSouvenirsView.swift
//  Bonheur_App
//
//  Created by caroletm on 01/10/2025.
//

import SwiftUI

struct FilteredSouvenirsView: View {
    
    @Binding var filteredSouvenirs: [any Souvenir]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        
        VStack (alignment : .leading) {
            
            Text("Filtered Souvenirs View")
                .font(.custom("SpaceMono-Bold", size: 20))
                .foregroundStyle(Color.white)
            
            ForEach(filteredSouvenirs, id: \.id) { souvenir in
                CadreMiniVignette(image: souvenir.photo ?? .photoDog)
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
        FilteredSouvenirsView(filteredSouvenirs: .constant([souvenirs[0]]))
    }
}

