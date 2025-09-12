//
//  SouvenirsView.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct SouvenirsView: View {
    
    //3 gridItems car 3 colonnes
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(.backgroundSouvenirs)
                    .ignoresSafeArea(.all)
                
                ScrollView{
                    
                    VStack (alignment: .leading) {
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(0..<5) { _ in
                                    CadreVignette(image : .photoVoiture)
                                }
                            }
                            .padding()
                        }
                        Divider()
                            .frame(width: 320, height: 1)
                            .background(Color.white)
                            .frame(maxWidth: .infinity) // prend toute la largeur
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        
                        HStack {
                            Text("Juillet 2025")
                                .font(.custom("SpaceMono-Bold", size: 20))
                                .foregroundStyle(.white)
                                .padding()
                            Spacer()
                            BoutonFiltre()
                                .padding(.trailing)
                        }
                        
                        // lazyVgrid : grille verticale de 3 colonnes
                        LazyVGrid(columns: columns) {
                            ForEach(0..<9) { _ in
                                CadreMiniVignette(image: .photoVoiture)
                                    .padding(.vertical, 8)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 60)
                
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    BoutonFusee(isPressed: false)
                }
                ToolbarItem(placement : .navigationBarLeading) {
                    ChevronGauche()
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
}
