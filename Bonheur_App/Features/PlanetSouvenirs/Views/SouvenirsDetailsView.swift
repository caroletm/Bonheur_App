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
                            navigationViewModel.path.append(AppRoute.planeteSouvenirs)
                        } label: {
                            BoutonRetour()
                        }
                        Spacer()
                    }
                    .padding()
                }
                .padding(.bottom, 10)
                
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
                    
                    VStack {
                        Text(souvenirsViewModel.dateFormatter(souvenir.date))
                            .font(.custom("SpaceMono-Bold", size: 20))
                            .opacity(0.7)
                            .padding(.bottom, 10)
                        
                        if souvenir.type == .mapInsert {
                            Text( "Tu as ajouté ce lieu")
                                .font(.custom("SpaceMono-Regular", size: 14))
                                .opacity(0.7)
                                .padding(.bottom, 10)
                            
                        }else if souvenir.type == .mission {
                            Text("\(souvenir.nom)")
                                .font(.custom("SpaceMono-Regular", size: 14))
                                .opacity(0.7)
                        }
                        
                        if souvenir.photo != nil {
                            Image(souvenir.photo ?? .photoDog)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 218, height: 284)
                        }else{
                            if souvenir.type == .mapInsert {
                                Image(.pointGps)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            if souvenir.type == .mission {
                                Image(.missionValide)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                        }
                        
                        if souvenir.type == .mapInsert {
                            Text("\(souvenir.nom)")
                                .font(.custom("SpaceMono-Bold", size: 16))
                                .opacity(0.7)
                        }
                        
                        ScrollView {
                            if souvenir.photo != nil {
                                Text("\(souvenir.description)")
                                    .font(.custom("SpaceMono-Regular", size: 12))
                                    .opacity(0.7)
                                    .frame(width : 285, height: 90)
                                    .multilineTextAlignment(.center)
                            }else{
                                Text("\(souvenir.description)")
                                    .font(.custom("SpaceMono-Regular", size: 12))
                                    .opacity(0.7)
                                    .frame(maxWidth : 285, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                            }
          
                        }
                        .frame(width : 285, height: 120)
                    }
                }
                .padding(.bottom, 100)
                
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


