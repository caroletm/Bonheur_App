//
//  SwiftUIView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionRecapValidationView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.blueGrey, Color.blueDark]),
                        startPoint: UnitPoint(x: 0.42, y: -0.17),
                        endPoint: UnitPoint(x: 0.46, y: 1.08)
                    )
                )
                .opacity(0.7)
                .frame(width: 363, height: 597)
                .cornerRadius(25)
            VStack{
                Text("bravo tu a accompli la mission")
                    .padding(.top,15)
                Image(.clapHands)
                    .padding(.vertical,50)
                HStack{
                    VStack{
                        Image(.photoVoiture)
                            .resizable()
                            .frame(width: 106,height: 138)
                        Image(.missionValide)
                            .resizable()
                            .frame(width: 56, height: 56)
                            .offset(x:0,y:-25)
                    }
                    VStack{
                        Text("date :")
                        Text("blablabliblablabla for en pomme ")
                    }
                }.padding(.vertical,30)
                Button {
                    
                } label: {
                    Image(.boutonOK)
                }.padding(.vertical,15)

            }
            .frame(width: 350, height: 580)
            .padding()
            
        }
    }
}

#Preview {
    MissionRecapValidationView()
}
