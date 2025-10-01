//
//  MissionCompletedView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionCompletedView: View {
    let challenge : Challenge
    @State private var memoryViewModel = MemoryChallengeViewModel()
    @State private var  navigateToRecap = false
    @State private var challengeMemoryCreated : MemoryChallenge? = nil
    @State var date = Date()
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
                                    .frame(width: 65, height: 65)
                                    .shadow(color: .white, radius: 10)
                                    .onTapGesture {
                                        memoryViewModel.selectedTheme = theme
                                    }
                            } else {
                                Image(theme.iconName)
                                    .resizable()
                                    .frame(width: 65, height: 65)
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
                        .fill(
                            Color.blueGrey
                        )
                        .frame(width:271,height: 198)
                    VStack{
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 36, height: 29)
                        Text("Photo optionnelle")
                            .font(.custom("Poppins-Light", size: 10))
                    }
                    
                }
                .padding(.vertical)
                ZStack{
                    HStack() {
                        Text("Date")
                            .font(.custom("SpaceMono-Bold", size: 14))
                            .padding(.leading)
                        
                        Text(": \(formattedDate(Date()))")
                            .font(.custom("SpaceMono-Bold", size: 20))
                        Spacer()
                        
                    }
                    
                }
                
                VStack(alignment: .leading,spacing: 10) {
                    Text("Details :")
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .padding(.leading)
                    
                    
                    TextField("Décris ton expérience", text: $memoryViewModel.descriptionText)
                        .padding()
                        .background(Color.blueGrey)
                    
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                    
                    
                        .frame(height: 150)
                    
                }
                .padding(.vertical,10)
                
                BoutonValider(isValid: false)
                
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




func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter.string(from: date)
}
