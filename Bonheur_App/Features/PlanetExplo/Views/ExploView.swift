//
//  Untitled.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct ExploView : View {
    
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @State var showModal: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                    Image(.backgroundExplora)
                        .ignoresSafeArea(.all)
                
                if !mapViewModel.showDetailPopup {
                    ZStack {
                        MapView()
                        Rectangle()
                            .fill(Color.clear)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 5)
                                    .frame(width: 363, height: 623)
                                    .cornerRadius(20)
                            )
                    }
                    .frame(width: 363, height: 623)
                    .cornerRadius(20)
                    .offset(y : -30)
                    Button {
                        showModal = true
                    }label:{
                        BoutonPlus()
                    }
                    .offset(y : 280)
                    
                    BoutonsRetoursFusee()
                        .padding()
                        .padding(.bottom, 20)
                    
                }else{
                    ZStack {
                        Color.black.opacity(0.3).ignoresSafeArea(.all)
                        DetailMapPoint(mapPoint: (mapViewModel.selectedMapPoint ?? mapViewModel.places.last) ?? mapPoints[0])
                    }
                }
            
            }
            .sheet(isPresented: $showModal) {
                CreateMapInsert(dismissModal: $showModal)
                    .presentationDragIndicator(.visible)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExploView()
        .environment(NavigationViewModel())
        .environment(MapViewModel())
        .environment(SouvenirsViewModel())
}
