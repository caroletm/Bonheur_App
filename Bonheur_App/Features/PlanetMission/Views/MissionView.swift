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
            VStack{
                
                VStack(alignment:.center){
                    Text("mission")
                        .font(.custom("SpaceMono-Bold", size: 20))
                        .foregroundStyle(.white)
                        .padding(.top)
                        
                    if let challenge = viewmissionmodel.currentChalenge {
                        Text(challenge.challengeName)
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundStyle(.white)
                            .padding(.top,90)
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

                        
//                        ajouter la data de la mission a la transmission
                        
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
                        viewmissionmodel.nextChallenge()
                    } label: {
                        Text("donner une autre mission")
                            .font(.custom("Poppins-Medium", size: 10))
                            .foregroundStyle(.white)
                            .underline()
                    }.padding(.vertical,20)
                    
                    
                }
                .background(
                    Image(.cadreOnboarding)
                        .resizable()
                        .scaledToFit()
                        .frame(width:333, height: 440)
                    
                )
                .padding(.top,110)
                
                
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
        }
    }
}


#Preview {
    MissionView()
        .environment(NavigationViewModel())
}
