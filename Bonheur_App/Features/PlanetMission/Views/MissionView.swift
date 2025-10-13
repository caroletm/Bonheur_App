//
//  MissionView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionView: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @State private var viewmissionmodel = ChallengeViewModel()
  
    var body: some View {
        ZStack{
            Image(.backgroundMissions)
                .ignoresSafeArea()
                
            Image(.cadreOnboarding)
                .resizable()
                .scaledToFit()
                .frame(width:333, height: 440)
                .padding(.bottom,130)
 
            VStack{
                
                VStack(alignment:.center){
                    Text("Mission du jour")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(.white)
                        .padding(.top)
                        
                    if let challenge = viewmissionmodel.currentChalenge {
                        Text(challenge.challengeName)
                            .font(.custom("Poppins-Regular", size: 16))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,16)
                            .padding(.top,70)
                    } else {
                        Text( "aucun challenge aujourd'hui")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundStyle(.white)
                            .padding(.top,90)
                    }
                    Button(action: {
                        
                        if let challenge = viewmissionmodel.currentChalenge {
                            navigationViewModel.path.append(AppRoute.missionAccepter(challenge: challenge))
                        }
                    }){
                        ZStack {
                            Rectangle()
                                .fill(Color.greyDarkButton)
                                .frame(width: 96, height: 42 )
                                .cornerRadius(3)
                            Rectangle()
                                .fill(Color.greyLightButton)
                                .frame(width: 84, height: 30)
                                .cornerRadius(3)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                            Text("Accepter")
                                .font(.custom ("SpaceMono-Bold", size: 14))
                                .foregroundStyle(Color.greyDarkText)
                        }
                    }.padding(.top, 70)
                    Button {
                        viewmissionmodel.ToggleChallenge()
                    } label: {
                        Text("donner une autre mission")
                            .font(.custom("Poppins-Medium", size: 10))
                            .foregroundStyle(.white)
                            .underline()
                    }.padding(.vertical,20)
                }
                .frame(width: 300, height: 380)
                Spacer()
                HStack(spacing:70){
                    Button {
                        navigationViewModel.path = NavigationPath()
                    }label:{
                        BoutonFusee(isPressed: false)
                    }.padding(.leading,40)
                   
                    Button {
                        navigationViewModel.path = NavigationPath()
                        navigationViewModel.path.append(AppRoute.landing(planete: planeteMission))
                    } label: {
                        BoutonRetour()
                    }
                    Spacer()
                }
                .padding(.bottom,50)
                
                
            }
            .padding(.top,170)
        }.navigationBarBackButtonHidden(true)
    }
}


#Preview {
    MissionView()
        .environment(NavigationViewModel())
}
