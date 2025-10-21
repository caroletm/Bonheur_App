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
    @State private var showCamera = false
    @State private var showModalDescription = false
    @Binding var dismissModal : Bool
    @State private var showLocalisationPopup : Bool = true
    @State private var showAdressModal = false
    @State private var isAlertPresented: Bool = false
    
    var body: some View {
        
        @Bindable var vm = mapViewModel
        
        ZStack {
            
            Image(.backgroundExplora)
                .ignoresSafeArea(.all)
            
            ScrollView {
                ZStack {
                    RectangleCreate()
                    
                    VStack {
                        
                        TextField("Nom du lieu", text: $vm.nomDuLieu)
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
                                        mapViewModel.selectedTheme = theme
                                    }
                                    print("themeSouvenir: \(souvenirViewModel.selectedTheme as Any)")
                                    print("themeMap : \(mapViewModel.selectedTheme as Any)")
                                    
                                }label: {
                                    
                                    VStack {
                                        Image(theme.iconName)
                                            .resizable()
                                            .frame(width: 65, height: 65)
                                            .shadow(color : theme.color, radius: 10)
                                        Text(theme.title).font(.custom("Poppins-Regular", size: 9))
                                            .foregroundStyle(.black)
                                    }
                                    .opacity( souvenirViewModel.selectedTheme == theme ? 1 : 0.3)
                                }
                            }
                        }.zIndex(2)
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
                        .zIndex(1)
                        .padding()
                        
                        HStack{
                            Text("Adresse :")
                                .font(.custom("SpaceMono-Bold", size: 14))
                                .padding(.leading)
                            
                            Button {
                                
                                showAdressModal = true
                                
                            }label : {
                                VStack(alignment: .center,spacing: 0){
                                    
                                    ZStack{
                                        
                                        if mapViewModel.isUserLocationSelected || mapViewModel.isManualAddressSelected{
                                            Text("\(mapViewModel.addressSelected ?? "adresse introuvable")")
                                                .font(.custom("SpaceMono-Bold", size: 16))
                                                .foregroundStyle(Color.black)
                                                .lineLimit(2)
                                        }else {
                                            Text("")
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
                                    Text(mapViewModel.descriptionText)
                                        .font(.custom("SpaceMono-Bold", size: 16))
                                        .foregroundColor(.black)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal)
                                        .padding(.top, -24)
                                }
                            }
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                Spacer()
                                
                                Button {
                                    
                                    Task {
                                        
                                        if souvenirViewModel.isValid && mapViewModel.isValid {
                                            
                                            if mapViewModel.isUserLocationSelected {
                                                
                                                guard let userLocation = mapViewModel.userLocation else {
                                                    print("Localisation inconnue.")
                                                    return
                                                }
                                                let latitude = userLocation.latitude
                                                let longitude = userLocation.longitude
                                                @Bindable var vm = mapViewModel
                                                let nom = vm.nomDuLieu.isEmpty ? "Lieu sans nom" : vm.nomDuLieu
                                                vm.image = souvenirViewModel.image
                                                vm.selectedTheme = souvenirViewModel.selectedTheme
                                                
                                                souvenirViewModel.createSouvenirCarte(name: nom, latitude: latitude, longitude: longitude)
                                                mapViewModel.createMapPoint(nom: nom, theme: vm.selectedTheme!, coordinate: userLocation)
                                                
                                            } else if mapViewModel.isManualAddressSelected {
                                                
                                                guard let addressSelected = mapViewModel.addressSelected else {
                                                    print("Adresse non renseignée.")
                                                    return
                                                }
                                                
                                                if let coordinate = await mapViewModel.getCoordinates(from: addressSelected) {
                                                    let nom = vm.nomDuLieu.isEmpty ? "Lieu sans nom" : vm.nomDuLieu
                                                    let selectedTheme = vm.selectedTheme
                                                    mapViewModel.image = souvenirViewModel.image
                                                    
                                                    souvenirViewModel.createSouvenirCarte(name: nom, latitude: coordinate.latitude, longitude: coordinate.longitude)
                                                    mapViewModel.createMapPoint(nom: nom, theme: selectedTheme!, coordinate: coordinate)
                                                }else{
                                                    print("Impossible d'obtenir les coordonnées de l'adresse")
                                                }
                                            }
                                            dismissModal = false
                                            print(mapViewModel.places.last?.nom ?? "")
                                            print(souvenirViewModel.souvenirsData.last?.nom ?? "")
                                            print("souvenirTheme: \( souvenirViewModel.selectedTheme ?? .energie )")
                                            print("souvenirDesc: \(souvenirViewModel.descriptionText)")
                                            print("mapNom: \(mapViewModel.nomDuLieu)")
                                            print("mapTheme: \( mapViewModel.selectedTheme ?? .energie )")
                                            print("mapDesc: \(mapViewModel.descriptionText)")
                                            print("mapAdresse : \(mapViewModel.addressSelected ?? "erreurAddress")")
                                        }else{
                                            isAlertPresented = true
                                            print(mapViewModel.places.last?.nom ?? "")
                                            print(souvenirViewModel.souvenirsData.last?.nom ?? "")
                                            print("souvenirTheme: \( souvenirViewModel.selectedTheme ?? .energie )")
                                            print("souvenirDesc: \(souvenirViewModel.descriptionText)")
                                            print("mapNom: \(mapViewModel.nomDuLieu)")
                                            print("mapTheme: \( mapViewModel.selectedTheme ?? .energie )")
                                            print("mapDesc: \(mapViewModel.descriptionText)")
                                            print("mapAdresse : \(mapViewModel.addressSelected ?? "erreurAddress")")
                                        }
                                        
                                    }
                                    
                                }label:{
                                    if souvenirViewModel.isValid && mapViewModel.isValid {
                                        BoutonValider(isValid: true)
                                    }else{
                                        BoutonValider(isValid: false)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        .frame(width: 285, height: 250)
                        .clipped()
                    }
                    .sheet(isPresented: $showModalDescription){
                        ModalDescription(dismissModalDescription: $showModalDescription)
                            .presentationDetents([.fraction(0.5)])
                        
                    }
                    .sheet(isPresented: $showAdressModal) {
                        ModalAdresse(closeAdressModal: $showAdressModal)
                            .presentationDetents([.fraction(0.3)])
                    }
                    .padding(.vertical,10)
                    .padding(.top, 20)
                    
                    .sheet(isPresented: $showCamera) {
                        @Bindable var vm = souvenirViewModel
                        
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            ImagePicker(sourceType: .camera, selectedImage: $vm.image)
                        } else {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image)
                        }
                    }
                    .alert("Creation invalide", isPresented: $isAlertPresented) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Les champs ne sont pas tous renseignés !")
                    }
                    .onAppear {
                        mapViewModel.resetForm()
                        souvenirViewModel.resetFormCarte()
                    }
        
                }
                
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            
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
