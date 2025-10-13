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
    @Environment(SouvenirsViewModel.self) private var souvenirViewModel
    
    @State var nomDuLieu : String = ""
    @State private var showCamera = false
    @State private var showModalDescription = false
    @Binding var dismissModal : Bool
    @State private var showLocalisationPopup : Bool = true
    @State private var showAdressModal = false
    
    var body: some View {
        
        ZStack {
            
            Image(.backgroundExplora)
                .ignoresSafeArea(.all)
            
            ScrollView {
                ZStack {
                    RectangleCreate()
                    
                    VStack {
                        
                        @Bindable var vm = mapViewModel
                        
                        TextField("Nom du lieu", text: $nomDuLieu)
                            .font(.custom("SpaceMono-Bold", size: 20))
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.top, 25)
                        
                        HStack {
                            
                            ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                                
                                Button {
                                    
                                    if souvenirViewModel.selectedTheme == theme {
                                        souvenirViewModel.selectedTheme = nil
                                    }else {
                                        souvenirViewModel.selectedTheme = theme
                                    }
                                    print(souvenirViewModel.selectedTheme as Any)
                                    
                                }label: {
                                    
                                    if souvenirViewModel.selectedTheme == theme {
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
                            if let selectedImage = souvenirViewModel.image {
                                
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
                            
                            Button {
                                
                                if mapViewModel.adressRentree.isEmpty && mapViewModel.addressFound == nil {
                                    showAdressModal = true
                                }
                            }label : {
                                VStack(alignment: .center,spacing: 0){
                                    
                                    ZStack{
                                        if mapViewModel.addressFound != nil {
                                            Text("\(mapViewModel.addressFound ?? "Adresse introuvable")")
                                                .font(.custom("SpaceMono-Bold", size: 16))
                                                .foregroundStyle(Color.black)
                                        }else{
                                            Text("")
                                        }
                                        if !mapViewModel.adressRentree.isEmpty {
                                            Text("\(mapViewModel.adressRentree)")
                                                .font(.custom("SpaceMono-Bold", size: 16))
                                                .foregroundStyle(Color.black)
                                                .lineLimit(2)
                                        }
                                        LigneTiretView()
                                    }
                                    .offset(y: 5)
                                }
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
                                    if !souvenirViewModel.descriptionText.isEmpty{
                                        Text(souvenirViewModel.descriptionText)
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
                                    guard souvenirViewModel.isValid else {
                                            print("❌ Informations incomplètes.")
                                            return
                                        }
                                        
                                        guard let userLocation = mapViewModel.userLocation else {
                                            print("❌ Localisation inconnue.")
                                            return
                                        }
                                        
                                        let latitude = userLocation.latitude
                                        let longitude = userLocation.longitude
                                        let nom = nomDuLieu.isEmpty ? "Lieu sans nom" : nomDuLieu
                                        
                                        souvenirViewModel.createSouvenirCarte(name: nom, latitude: latitude, longitude: longitude)
                                        
                                        // Fermer la vue après création
                                        dismissModal = false
                                    
                                }label:{
                                    if souvenirViewModel.isValid {
                                        BoutonValider(isValid: true)
                                    }else{
                                        BoutonValider(isValid: false)
                                    }
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
                    .sheet(isPresented: $showAdressModal) {
                        ModalAdresse(closeAdressModal: $showAdressModal)
                            .presentationDetents([.fraction(0.5)])
                    }
                    .padding(.vertical,10)
                    .padding(.top, 20)
                    
                    
                    
                }
                
                .padding()
            }
            if showLocalisationPopup {
                ZStack{
                    Color.black.opacity(0.5)
                        .ignoresSafeArea(.all)
                    LocalisationFound(closePopup: $showLocalisationPopup)
                }
            }
        }
    }
}

#Preview {
    CreateMapInsert(dismissModal: .constant(false))
        .environment(NavigationViewModel())
        .environment(MapViewModel())
        .environment(SouvenirsViewModel())
}
