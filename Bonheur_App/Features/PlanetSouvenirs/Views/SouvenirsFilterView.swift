//
//  SouvenirsFilterView.swift
//  Bonheur_App
//
//  Created by caroletm on 21/09/2025.
//

import SwiftUI

struct SouvenirsFilterView: View {
    var body: some View {
        
        ZStack (alignment: .top) {
            Image(.backgroundSouvenirs)
                .ignoresSafeArea(.all)
 
                CadreBlanc()
                    .padding(.top, 100)

            HStack {
                VStack (alignment: .leading, spacing: 40) {
                    Text("Date : ")
                    HStack {
                        Text("Défi : ")
                        Spacer()
                        BoutonSwitch(isOn: true)
                    }
                    HStack {
                        Text("Map :")
                        Spacer()
                        BoutonSwitch(isOn: false)
                    }
                    Text("Type :")
                    HStack {
                        ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                            Image(theme.iconName)
                                .resizable()
                                .frame(width: 150, height: 150)
                        }
                        Spacer()
                    }
                }
                .font(.custom("SpaceMono-Bold", size: 16))
                .foregroundColor(.white)
                .frame(width: 300, height: 433)
//                .padding(.top, 130)
                .padding(50)
            }
        }
    }
}

#Preview {
    SouvenirsFilterView()
}
