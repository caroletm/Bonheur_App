//
//  SwiftUIView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionRecapValidationView: View {
    
    
    let memoryChallenge: MemoryChallenge
    var body: some View {
        ZStack{
            Image(.backgroundMissions)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("bravo tu a accompli la mission")
                    .padding(.top,15)
                Image(.clapHands)
                    .padding(.vertical,50)
                HStack{
                    VStack{
                        Image(memoryChallenge.imageMemory ?? "photoSmile")
                            .resizable()
                            .frame(width: 106, height: 138)
                            .scaledToFit()

                        Image(.missionValide)
                            .resizable()
                            .frame(width: 56, height: 56)
                            .offset(x:0,y:-25)
                    }
                    VStack{
                        Text(memoryChallenge.creationDate)
                        Text(memoryChallenge.descriptionMemory)
                    }
                }.padding(.vertical,30)
                Button {
                    
                } label: {
                    Image(.boutonOK)
                }.padding(.vertical,15)

            }.padding(30)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.blueGrey, Color.blueDark]),
                            startPoint: UnitPoint(x: 0.42, y: -0.17),
                            endPoint: UnitPoint(x: 0.46, y: 1.08)
                        )
                    )
                    .opacity(0.7)
            )
            .frame(width:350 , height: 680)
            
            
        }
    }
}

#Preview {
    MissionRecapValidationView(
        memoryChallenge:MemoryChallenge(
            nameMemory: "me ballader"
            , descriptionMemory: "cetait cool"
            , imageMemory: nil, themeMemory: .energie
            , creationDate: "09/Octobre/2025"
         
        ))
}
