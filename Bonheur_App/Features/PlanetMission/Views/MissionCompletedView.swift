//
//  MissionCompletedView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionCompletedView: View {
    let challenge : Challenge
    @Bindable private var memoryViewModel = MemoryChallengeViewModel()
    @State private var showCamera = false
    
    @State private var  navigateToRecap = false
    @State private var challengeMemoryCreated : MemoryChallenge? = nil
    
    
    
    @State private var selected : UIImage? = nil
    @State private var showModalDescription = false
    
    @State private var descriptionText = ""
    var body: some View {
        ZStack{
            Image(.backgroundMissions)
                .ignoresSafeArea()
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.blueGrey, Color.blueDark]),
                        startPoint: UnitPoint(x: 0.42, y: -0.17),
                        endPoint: UnitPoint(x: 0.46, y: 1.08)
                    )
                )
                .opacity(0.7)
                .frame(width: 363, height: 703)
                .cornerRadius(25)
            VStack{
                Text(challenge.challengeName)
                    .font(.custom("SpaceMono-Bold", size: 20))
                HStack(spacing:18){
                    ForEach(ThemeType.allCases,id: \.self){theme in
                        VStack{
                            if memoryViewModel.selectedTheme == theme {
                                Image(theme.iconName)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .shadow(color: .white, radius: 10)
                                    .onTapGesture {
                                        memoryViewModel.selectedTheme = theme
                                    }
                            } else {
                                Image(theme.iconName)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .opacity(0.3)
                                    .onTapGesture {
                                        memoryViewModel.selectedTheme = theme
                                    }
                            }
                            Text(theme.rawValue)
                                .font(.custom("Poppins-Medium", size: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                ZStack{
                    Rectangle()
                        .fill(Color.blueGrey)
                        .frame(width:271,height: 198)
                        .cornerRadius(25)
                        .onTapGesture {
                            showCamera = true
                        }
                    VStack{
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 36, height: 29)
                        Text("Photo optionnelle")
                            .font(.custom("Poppins-Light", size: 10))
                    }
                    
                }
                .padding(.vertical)
                .sheet(isPresented: $showCamera) {
                    ImagePicker(sourceType: .camera, selectedImage: $memoryViewModel.image)
                }
                ZStack{
                    HStack() {
                        Text("Date")
                            .font(.custom("SpaceMono-Bold", size: 14))
                            .padding(.leading)
                        VStack(alignment: .leading,spacing: 0){
                            Text(": \(memoryViewModel.formattedDate())")
                                .font(.custom("SpaceMono-Bold", size: 20))
                            LigneTiretView()
                        }
                        .padding(.leading)
                        Spacer()
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Details :")
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .padding(.leading)
                        .padding(.bottom,20)
                    Button {
                        showModalDescription = true
                    } label: {
                        ZStack(alignment: .topLeading) {
                            // Les lignes pointillées
                            VStack(spacing: 30) {
                                LigneTiretView()
                                LigneTiretView()
                                LigneTiretView()
                            }
                            if !memoryViewModel.descriptionText.isEmpty{
                                Text(memoryViewModel.descriptionText)
                                    .font(.custom("SpaceMono-Bold", size: 16))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                    .padding(.top, -30)
                            }
                        }
                    }
                    .sheet(isPresented: $showModalDescription){
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Details :")
                                .font(.custom("SpaceMono-Bold", size: 16))
                                .padding(.top)
                            TextField("Décris ton expérience", text: $memoryViewModel.descriptionText, axis: .vertical)
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(height: 150)
                            Spacer()
                            Button(action: {
                                showModalDescription = false
                            }) {
                                ZStack (){
                                    Rectangle()
                                        .fill(Color.greyDarkButton)
                                        .frame(width: 90, height: 42)
                                        .cornerRadius(3)
                                    
                                    Rectangle()
                                        .fill(Color.greyLightButton)
                                        .frame(width: 78, height: 30)
                                        .cornerRadius(3)
                                        .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                                    Text("OK")
                                        .font(.custom ("SpaceMono-Bold", size: 14))
                                        .foregroundStyle(Color.greyDarkText)
                                }.padding(.leading,150)
                            }
                        }
                        .padding()
                        .frame(alignment: .center)
                    }
    
                }
                .padding(.vertical,10)
                Button(action:{
//                    redirection et affichage souvenir
                }){
                    BoutonValider(isValid: false)
                        .padding()
                }
            }
            .frame(width: 350, height: 680)
            .padding()
            BoutonRetour()
                .offset(x:0,y:385)
        }
    }
}

#Preview {
    MissionCompletedView(challenge: Challenge(challengeName: "boire de l'eau", challengeDay: false))
    
}





