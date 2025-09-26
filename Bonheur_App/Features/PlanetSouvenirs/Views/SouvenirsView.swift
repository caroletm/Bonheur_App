//
//  SouvenirsView.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct SouvenirsView: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel

    
    //3 gridItems car 3 colonnes
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        
        let groupedSouvenirs = souvenirsViewModel.groupSouvenirsByMonth(souvenirsViewModel.souvenirsData)
        let sortedSouvenirs = souvenirsViewModel.souvenirsData.sorted { $0.date > $1.date }
        let last5Souvenirs = Array(sortedSouvenirs.prefix(5))
      
        NavigationView {
            ZStack {
                Image(.backgroundSouvenirs)
                    .ignoresSafeArea(.all)
                
                ScrollView{
                    
                    VStack  (alignment: .leading){
                        
                        ForEach(groupedSouvenirs, id: \.key) { month, souvenirsOfMonth in
                            
                            VStack (alignment: .leading) {
                                ScrollView (.horizontal) {
                                    HStack {
                                        ForEach(last5Souvenirs, id: \.id) { souvenir in
                                            CadreVignette(image : souvenir.photo ?? .photoDog, date : Date(), iconTheme: souvenir.theme.iconName)
                                        }
                                    }
                                    .padding()
                                }
                                Divider()
                                    .frame(width: 320, height: 1)
                                    .background(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                
                                HStack {
                                    Text(month.capitalized)
                                        .font(.custom("SpaceMono-Bold", size: 20))
                                        .foregroundStyle(.white)
                                        .padding()
                                    Spacer()
                                    BoutonFiltre()
                                        .padding(.trailing)
                                }
                                
                                // lazyVgrid : grille verticale de 3 colonnes
                                LazyVGrid(columns: columns) {
                                    ForEach(souvenirsOfMonth, id: \.id) { souvenir in
                                        CadreMiniVignette(image: souvenir.photo ?? .photoDog)
                                            .padding(.vertical, 8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top, 60)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        BoutonFusee(isPressed: false)
                }
                ToolbarItem(placement : .navigationBarLeading) {
                    BoutonChevron(image: .chevronLeft)
                }
                ToolbarItem(placement: .principal) {
                    Text("Mes souvenirs")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(.white)
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SouvenirsView()
        .environment(SouvenirsViewModel())
        .environment(NavigationViewModel())
}
