//
//  SwiftUIView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionRecapValidationView: View {
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    @Environment(NavigationViewModel.self) private var navigationViewModel
//    @Bindable private var souvenirViewModel = SouvenirsViewModel()
    @Environment(\.dismiss) private var dismiss
    @Binding var dismissModal: Bool

    let memoryChallenge: SouvenirDTO
    var body: some View {
        ZStack{
            Image(.backgroundMissions)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Bravo tu a accompli ta mission du : ")
                    .padding(.vertical,15)
                    .font(.custom("SpaceMono-Bold", size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(TextAlignment.center)
                Text(souvenirsViewModel.dateFormatter(memoryChallenge.date))
                    .font(.custom("SpaceMono-Bold", size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom,35)
                VStack {
                    VStack (alignment: .center,spacing: 10){
                        ZStack {
                            Image(memoryChallenge.theme.iconName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .offset(y: -38)
                            Text("\"\(memoryChallenge.nom)\"")
                                .font(.custom("Poppins-bold", size: 20))
                                .foregroundColor(.black)
                                .padding(.top,10)
                        }
                        HStack{
                            if let photoName = memoryChallenge.photo, !photoName.isEmpty {
                                    Image(photoName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 106, height: 138)
                                        .padding(.leading, 10)
                                }
                                VStack(alignment: .leading) {
                                    Text(memoryChallenge.description)
                                        .font(.custom("SpaceMono-Regular", size: 12))
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                }
                        }
                    }
                    Spacer()
                }
                .frame(width: 341, height: 288)
                .background {
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .cornerRadius(12)
                        .opacity(0.8)
                }
                Image("defiValidate")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .offset(x:0,y:-25)
                Button {
                    navigationViewModel.path.append(
                            AppRoute.planeteUserTest
                        )
                    dismiss()
                    
                } label: {
                   BoutonText(text: "OK", width: 45)
                }.padding(.vertical,5)
            }.padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white, Color.blueGrey, Color.blueDark]),
                                startPoint: UnitPoint(x: 0.42, y: -0.17),
                                endPoint: UnitPoint(x: 0.46, y: 1.08)
                            )
                        )
                        .opacity(0.7)
                )
                .frame(width:350 , height: 680)
        }
    }
}
#Preview {
    MissionRecapValidationView(
        dismissModal: .constant(false), memoryChallenge: souvenirs[1]
    )
    .environment(SouvenirsViewModel())
    .environment(NavigationViewModel())
}
