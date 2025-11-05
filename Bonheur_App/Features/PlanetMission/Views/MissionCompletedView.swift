//
//  MissionCompletedView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//
import SwiftUI
struct MissionCompletedView: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    let challenge : MissionDTO
    @Environment(SouvenirsViewModel.self) private var souvenirViewmodel
    
    @State private var showCamera = false
    @State var text: String = ""
    @State private var showModalDescription = false
    @State private var fitsInOneLine = true
    @State private var memoryChallengeForRecap: SouvenirDTO? = nil
    @State private var showValidationAlert = false
//    @State var showModal : Bool = false
    
    var body: some View {
        
        ZStack{
            Image(.backgroundMissions)
                .ignoresSafeArea()
            if !souvenirViewmodel.showValidationPopup {
                
            RectangleFond()
            VStack{
                VStack{
                    Text(challenge.nom)
                        .font(.custom("SpaceMono-Bold", size: fitsInOneLine ? 20 : 16))
                        .opacity(0.8)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal,16)
                        .multilineTextAlignment(.center)
                        .padding(.top,25)
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
                        ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                            Button {
                                if souvenirViewmodel.selectedTheme == theme {
                                    souvenirViewmodel.selectedTheme = nil
                                }else {
                                    souvenirViewmodel.selectedTheme = theme
                                }
                                print(souvenirViewmodel.selectedTheme as Any)
                            }label: {
                                VStack {
                                    Image(theme.iconName)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .shadow(color : theme.color, radius: 10)
                                    Text(theme.title).font(.custom("Poppins-Regular", size: 9))
                                        .foregroundStyle(.black)
                                }
                                .opacity( souvenirViewmodel.selectedTheme == theme ? 1 : 0.3)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 15)
                    ZStack{
                        if let selectedImage = souvenirViewmodel.image {
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
                        @Bindable var vm = souvenirViewmodel
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            ImagePicker(sourceType: .camera, selectedImage: $vm.image)
                        } else {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image)
                        }
                    }
                    ZStack{
                        HStack() {
                            Text("Date")
                                .font(.custom("SpaceMono-Bold", size: 14))
                                .padding(.leading)
                                .opacity(0.8)
                            VStack(alignment: .leading,spacing: 0){
                                Text(": \(souvenirViewmodel.formattedDate())")
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
                                if !souvenirViewmodel.descriptionText.isEmpty{
                                    Text(souvenirViewmodel.descriptionText)
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
                                Text("Donne plus de details concernant ton action :")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                    .padding(.horizontal)
                                TextEditor( text: $text)
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .padding(8)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .frame(maxHeight: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(style: StrokeStyle(lineWidth: 1))
                                    )
                                    .padding()
                                Button(action: {
                                    showModalDescription = false
                                    souvenirViewmodel.descriptionText = text
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
                            .padding(20)
                            .frame(alignment: .center)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                        }
                    }
                    .padding(.vertical,10)
                    Button{
                        if souvenirViewmodel.isValid {
                            Task{
                                if let newSouvenir = try? await souvenirViewmodel.buildSouvenirChallenge(name: challenge.nom,missionID: challenge.id!
                                ) {
                                    memoryChallengeForRecap = newSouvenir

                                }else {
                                    showValidationAlert = true
                                }
                            }
                            print("\(String(describing: memoryChallengeForRecap))")
                            souvenirViewmodel.showValidationPopup = true
                        }else{
                            showValidationAlert = true
                        }
                    }label :{
                        if souvenirViewmodel.isValid {
                            BoutonValider(isValid: true)
                        }else{
                            BoutonValider(isValid: false)
                        }
                    }
                    .alert("Champs requis", isPresented: $showValidationAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Veuillez sélectionner un thème et remplir la description avant de valider.")
                    }
                }
                .frame(width: 350,height: 680)
                .padding(.top)
                Button {
                    if !navigationViewModel.path.isEmpty {
                        navigationViewModel.path.removeLast()
                    }
                } label :{
                    BoutonRetour()
                }
                .padding(.top)
            }.navigationBarBackButtonHidden(true)
//                .sheet(item: $memoryChallengeForRecap) { memoryChallenge in
//                    MissionRecapValidationView(memoryChallenge: memoryChallenge)
//                }
            }else{
                MissionRecapValidationView(memoryChallenge: memoryChallengeForRecap ?? souvenirs[0])
            }
        }
        .onAppear {
            souvenirViewmodel.resetFormMission()
        }
    }
}

#Preview {
    MissionCompletedView(
        challenge: MissionDTO(id: UUID(),
                              nom: "String"))
    .environment(NavigationViewModel())
    .environment(SouvenirsViewModel())
}





