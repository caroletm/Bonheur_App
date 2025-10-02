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
        let isFilterOn : Bool =
        souvenirsViewModel.filters.month != nil ||
        souvenirsViewModel.filters.year != nil ||
        souvenirsViewModel.filters.isDefi ||
        souvenirsViewModel.filters.isMap ||
        !souvenirsViewModel.filters.theme.isEmpty
        
        NavigationView {
            
            ZStack {
                Image(.backgroundSouvenirs)
                    .ignoresSafeArea(.all)
                
                if !isFilterOn {
                    VStack {
                        ScrollView{
                            
                            VStack  (alignment: .leading){
                                
                                
                                ScrollView (.horizontal) {
                                    HStack {
                                        ForEach(last5Souvenirs, id: \.id) { souvenir in
                                            
                                            NavigationLink {
                                                SouvenirsDetailsView(souvenir: souvenir)
                                            }label :{
                                                CadreVignette(image : souvenir.photo ?? .photoDog, date : souvenir.date, iconTheme: souvenir.theme.iconName)
                                            }
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
                                
                                
                                ForEach(groupedSouvenirs, id: \.key) { month, souvenirsOfMonth in
                                    
                                    if month == groupedSouvenirs.first?.key {
                                        
                                        HStack {
                                            Text(month.capitalized)
                                                .font(.custom("SpaceMono-Bold", size: 20))
                                                .foregroundStyle(.white)
                                                .padding()
                                            Spacer()
                                            Button {
                                                navigationViewModel.path.append(AppRoute.souvenirsFiltre)
                                            }label: {
                                                BoutonFiltre()
                                                    .padding(.trailing)
                                            }
                                        }
                                    } else {
                                        Text(month.capitalized)
                                            .font(.custom("SpaceMono-Bold", size: 20))
                                            .foregroundStyle(.white)
                                            .padding()
                                    }
                                    
                                    // lazyVgrid : grille verticale de 3 colonnes
                                    LazyVGrid(columns: columns) {
                                        ForEach(souvenirsOfMonth, id: \.id) { souvenir in
                                            NavigationLink {
                                                SouvenirsDetailsView(souvenir: souvenir)
                                            }label: {
                                                CadreMiniVignette(image: souvenir.photo ?? .photoDog)
                                                    .padding(.vertical, 8)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top, 60)

                    
                }else {
                    
                    VStack {
                        FilteredSouvenirsView()
                    }
                    .padding(.top, 60)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigationViewModel.path = NavigationPath()
                    }label:{
                        BoutonFusee(isPressed: false)
                    }
                }
                ToolbarItem(placement : .navigationBarLeading) {
                    Button {
                        
                        if !isFilterOn {
                            navigationViewModel.path = NavigationPath()
                            navigationViewModel.path.append(AppRoute.landing(planete: planeteSouvenirs))
                        }else {
                            souvenirsViewModel.resetFilters()
                        }
                        
                    }label : {
                        BoutonChevron(image: .chevronLeft)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Mes souvenirs")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(.white)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SouvenirsView()
        .environment(SouvenirsViewModel())
        .environment(NavigationViewModel())
}
