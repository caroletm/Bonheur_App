//
//  SouvenirsDetailsView.swift
//  Bonheur_App
//
//  Created by caroletm on 02/10/2025.
//

import SwiftUI

struct SouvenirsDetailsView: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
    
    var souvenir : Souvenir
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image(.backgroundSouvenirs)
                    .ignoresSafeArea(.all)
                
                ZStack {
                    RectangleFond()
                    
                    VStack {
                        Image(souvenir.theme.iconName)
                            .resizable()
                            .frame(width: 65, height: 65)
                            .shadow(color : souvenir.theme.color, radius: 15)
                        Text(souvenir.theme.title)
                            .font(.custom("Poppins-Regular", size: 12))
                    }
                    .offset(y: -315)
                    
                    VStack (spacing : 15) {
                        Text(souvenirsViewModel.dateFormatter(souvenir.date))
                            .font(.custom("SpaceMono-Bold", size: 20))
                            .opacity(0.7)
                            .padding(10)
                        
                        Text( souvenir.type == .mapInsert ?  "Tu as ajouté ce lieu" : "Tu as relevé ce défi")
                            .font(.custom("SpaceMono-Regular", size: 14))
                            .opacity(0.7)
                        
                        if souvenir.photo != nil {
                            Image(souvenir.photo ?? .photoDog)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 218, height: 284)
                        }else{
                            souvenir.type == .mapInsert ?
                            Image(.pointGps)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                            :
                            Image(.missionValide)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding()
                        }
                        
                        Text("\(souvenir.nom)")
                            .font(.custom("SpaceMono-Bold", size: 16))
                            .opacity(0.7)
                            .padding(.bottom, 10)
                        
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            Text(souvenir.description)
                                .font(.custom("SpaceMono-Regular", size: 12))
                                .opacity(0.7)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(width: 285, height: 250)
                        .clipped()
                    }
                    .offset(y: souvenir.photo != nil ? 90 : 0)
                }
                .padding()
                
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            navigationViewModel.path = NavigationPath()
                        }label :{
                            BoutonFusee(isPressed: false)
                        }
                        Spacer()
                            .frame(width: 100)
                        Button {
                            navigationViewModel.path.removeLast()
                        } label: {
                            BoutonRetour()
                        }
                        Spacer()
                    }
                    .padding()
                }
                .padding(.bottom, 10)
                
                if souvenir.photo != nil {
                    if souvenir.type == .mission {
                        Image(.missionValide)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .offset(x: 0, y: 260)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SouvenirsDetailsView(souvenir: souvenirs[1])
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}


