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
    @Environment(MemoryChallengeViewModel.self) private var memoryViewModel
    
    @State var showModal: Bool = false

        
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(.backgroundExplora)
                    .ignoresSafeArea(.all)
                
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
        .environment(MemoryChallengeViewModel())
}
