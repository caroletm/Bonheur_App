//
//  MissionCompletedView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionCompletedView: View {

    @Environment(NavigationViewModel.self) private var navigationViewModel
    let challenge : Challenge
    @Bindable private var memoryViewModel = MemoryChallengeViewModel()
    @State private var showCamera = false
    
    @State private var  navigateToRecap = false
    @State private var challengeMemoryCreated : MemoryChallenge? = nil

    @State private var selected : UIImage? = nil
    @State private var showModalDescription = false
    @State private var fitsInOneLine = true
    
    @State private var descriptionText = ""
    var body: some View {
        ZStack{
            Image(.backgroundMissions)
                .ignoresSafeArea()
            RectangleFond()
            
            VStack{
                Text(challenge.challengeName)
                    .font(.custom("SpaceMono-Bold", size: fitsInOneLine ? 20 : 16))
                    .opacity(0.8)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal,16)
                    .multilineTextAlignment(.center)
                    .padding(.top,16)
                    .background(
                        GeometryReader { proxy in
                            Color.clear.onAppear {
                                
                                let lineHeight = UIFont(name: "SpaceMono-Bold", size: 20)?.lineHeight ?? 20
                                let numberOfLines = proxy.size.height / lineHeight
                                fitsInOneLine = numberOfLines <= 1.5
                            }
                        }
                    )
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
                .padding(.bottom, 15)
                ZStack{
                    if let selectedImage = memoryViewModel.image {
                        
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 271, height: 198)
                            .clipped()
                            .cornerRadius(25)
                            .onTapGesture {
                                showCamera = true
                            }
                    } else {
                        Rectangle()
                            .fill(Color.blueGrey)
                            .frame(width:271,height: 178)
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
                }
                
                .sheet(isPresented: $showCamera) {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        ImagePicker(sourceType: .camera, selectedImage: $memoryViewModel.image)
                    } else {
                        
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $memoryViewModel.image)
                    }
                }
                ZStack{
                    HStack() {
                        Text("Date")
                            .font(.custom("SpaceMono-Bold", size: 14))
                            .padding(.leading)
                            .opacity(0.8)
                        VStack(alignment: .leading,spacing: 0){
                            Text(": \(memoryViewModel.formattedDate())")
                                .opacity(0.8)
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
                        .padding(.bottom,10)
                        .opacity(0.8)
                    
                    Button {
                        showModalDescription = true
                    } label: {
                       
                            ZStack(alignment: .topLeading) {
                                // Les lignes pointillées
                                VStack(spacing: 24) {
                                    LigneTiretView()
                                    LigneTiretView()
                                    LigneTiretView()
                                }
                                if !memoryViewModel.descriptionText.isEmpty{
                                    Text(memoryViewModel.descriptionText)
                                        .font(.custom("SpaceMono-Bold", size: 16))
                                        .foregroundColor(.black)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal)
                                        .padding(.top, -24)
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
                Button
                {
//                    print(memoryViewModel.isValid)
                }label :{
                    
                    if memoryViewModel.isValid {
                        BoutonValider(isValid: true)
                    }else{
                        BoutonValider(isValid: false)
                    }
                }
            }
            .frame(width: 350,height: 680)
            Button {
                //                routes
            } label: {
                BoutonRetour()
                    .offset(x:0,y:385)
            }
        }
        
    }
}

#Preview {
    MissionCompletedView(challenge: Challenge(challengeName: "promene toi dans un parc en plein été à l'ombre", challengeDay: false)).environment(NavigationViewModel())
    
}





