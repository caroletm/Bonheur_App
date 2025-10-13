//
//  MapPointCreate.swift
//  Bonheur_App
//
//  Created by caroletm on 10/10/2025.
//

import SwiftUI


struct CreateMapInsert: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    @Environment(MemoryChallengeViewModel.self) private var memoryViewModel
    
    @State var nomDuLieu : String = ""
    @State private var showCamera = false
    @State private var showModalDescription = false
    @Binding var dismissModal : Bool
    
    var body: some View {
        
      
            
            ZStack {
                
                Image(.backgroundExplora)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                ZStack {
                    RectangleCreate()
                    
                    VStack {
                        TextField("Nom du lieu", text: $nomDuLieu)
                            .font(.custom("SpaceMono-Bold", size: 20))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        HStack {
                            
                            ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                                
                                Button {
                                    
                                    if mapViewModel.mapThemeSelected == theme {
                                        mapViewModel.mapThemeSelected = nil
                                    }else {
                                        mapViewModel.mapThemeSelected = theme
                                    }
                                    print(mapViewModel.mapThemeSelected as Any)
                                    
                                }label: {
                                    
                                    if mapViewModel.mapThemeSelected == theme {
                                        VStack {
                                            Image(theme.iconName)
                                                .resizable()
                                                .frame(width: 65, height: 65)
                                                .shadow(color : theme.color, radius: 10)
                                            Text(theme.title).font(.custom("Poppins", size: 9))
                                                .foregroundStyle(.black)
                                        }
                                    }else{
                                        VStack {
                                            Image(theme.iconName)
                                                .resizable()
                                                .frame(width: 65, height: 65)
                                                .shadow(color : theme.color, radius: 10)
                                                .opacity(0.3)
                                            Text(theme.title).font(.custom("Poppins", size: 9))
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                            }
                        }
                        ZStack{
                            if let selectedImage = memoryViewModel.image {
                                
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 271, height: 198)
                                    .clipped()
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        showCamera = true
                                    }
                            } else {
                                Rectangle()
                                    .fill(Color.blueGrey)
                                    .opacity(0.3)
                                    .frame(width: 271, height: 198)
                                    .cornerRadius(10)
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
                                .opacity(0.6)
                            }
                        }
                        .padding()
                        
                  

                        
                        HStack{
                            Text("Adresse :")
                                .font(.custom("SpaceMono-Bold", size: 14))
                                .padding(.leading)
                            
                            VStack(alignment: .center,spacing: 0){
                                Text("adresse")
                                    .font(.custom("SpaceMono-Bold", size: 20))
                                LigneTiretView()
                            }
                            
                        }
                        .frame(width: 300)
                        .opacity(0.7)
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Details :")
                                .font(.custom("SpaceMono-Bold", size: 14))
                                .padding(.leading)
                                .padding(.bottom,20)
                                .opacity(0.6)
                            
                            
                            Button {
                                showModalDescription = true
                            } label: {
                                
                                ZStack(alignment: .topLeading) {
                                    VStack(spacing: 40) {
                                        
                                        ForEach (0..<3) { _ in
                                            LigneTiretView()
                                        }
                                    }
                                    .frame(width: 300)
                                    if !memoryViewModel.descriptionText.isEmpty{
                                        Text(memoryViewModel.descriptionText)
                                            .font(.custom("SpaceMono-Bold", size: 16))
                                            .foregroundColor(.greyDarkText)
                                            .lineLimit(3)
                                            .multilineTextAlignment(.leading)
                                            .padding(.horizontal)
                                            .padding(.top, -24)
                                    }
                                }
                            }
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                Spacer()
                                Button {
                                    mapViewModel.addMapPoint(from: nomDuLieu, theme: mapViewModel.mapThemeSelected ?? .inspiration) { success in
                                        if success {
                                            print("Nouveau point ajouté sur la carte !")
                                           dismissModal = false
                                        } else {
                                            print("Erreur : impossible d’ajouter ce lieu.")
                                        }
                                    }
                                }label:{
                                    BoutonValider(isValid: false)
                                }
                                    .padding()
                                Spacer()
                            }
                        }
                        
                        
                        .frame(width: 285, height: 250)
                        .clipped()
                     
                        
                    }
                    .sheet(isPresented: $showModalDescription){
                        ModalDescription()
                            .presentationDetents([.fraction(0.5)])

                    }
                    .padding(.vertical,10)
                    
          

                }
                
                .padding()
            }
            
        }
    }
}

#Preview {
    CreateMapInsert(dismissModal: .constant(false))
        .environment(NavigationViewModel())
        .environment(MapViewModel())
        .environment(MemoryChallengeViewModel())
}
