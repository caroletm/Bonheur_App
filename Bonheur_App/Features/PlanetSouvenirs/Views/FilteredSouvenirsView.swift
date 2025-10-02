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
            
            if souvenirsViewModel.filters.month != nil && souvenirsViewModel.filters.year != nil {
                
                HStack {
                    
                    Text("Juillet 2025")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(Color.white)
                    
                }
                
            }else {
                Spacer()
            }
            
            LazyVGrid(columns: columns) {
                ForEach(souvenirsViewModel.filteredSouvenirs, id: \.id) { souvenir in
                    CadreMiniVignette(image: souvenir.photo ?? .photoDog)
                }
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

