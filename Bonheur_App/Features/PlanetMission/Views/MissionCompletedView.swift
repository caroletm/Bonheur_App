//
//  MissionCompletedView.swift
//  Bonheur_App
//
//  Created by cyrilH on 26/09/2025.
//

import SwiftUI

struct MissionCompletedView: View {
    @State var date = Date()
    @State private var descriptionText: String = ""
    var body: some View {
        ZStack{
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
                Text("mission")
                    .font(.custom("SpaceMono-Bold", size: 20))
                    
                HStack(spacing:18){
                    
                    VStack{
                        Image(.logoInspi)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60,height: 60)
                        Text("Inspiration")
                            .font(.custom("Poppins-Medium", size: 10))
                    }
                    
                    VStack{
                        Image(.logoSocial)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60,height: 60)
                        Text("Social")
                            .font(.custom("Poppins-Medium", size: 10))
                    }
                    VStack{
                        Image(.logoApprentissage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60,height: 60)
                        Text("Apprentissage")
                            .font(.custom("Poppins-Medium", size: 10))
                    }
                    VStack{
                        Image(.logoEnergie)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60,height: 60)
                        Text("Energie")
                            .font(.custom("Poppins-Medium", size: 10))
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
                
                HStack() {
                    Text("Date")
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .padding(.leading)
                        
                    Text(": \(formattedDate(Date()))")
                        .font(.custom("SpaceMono-Bold", size: 20))
                    Spacer()
                }
                
                VStack(alignment: .leading,spacing: 10) {
                    Text("Details :")
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .padding(.leading)
                    
                    
                    TextField("clcl", text: $descriptionText)
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
            
        }
    }
}

#Preview {
    MissionCompletedView()
    
}




func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter.string(from: date)
}
