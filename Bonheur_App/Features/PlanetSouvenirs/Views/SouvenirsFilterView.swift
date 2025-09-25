//
//  SouvenirsFilterView.swift
//  Bonheur_App
//
//  Created by caroletm on 21/09/2025.
//

import SwiftUI

struct SouvenirsFilterView: View {
    
    @State private var selectedMonth = 7
    @State private var selectedYear = 2025
    
    @State var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                  "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
    
 @State var years = Array(2010...2030)
    
    var body: some View {
        
        ZStack (alignment: .top) {
            Image(.backgroundSouvenirs)
                .ignoresSafeArea(.all)
            
            CadreBlanc()
                .padding(.top, 100)
            
            VStack (spacing:15) {
                HStack{
                    Text("Date : ")
                    Spacer()
                    ZStack {
                        HStack {
                          MonthPicker(selectedMonth: $selectedMonth, months: $months)
                            YearPicker(selectedYear: $selectedYear, years: $years)
                        }
                        .padding(.bottom, 10)
                        LignePointilles()
                    }
                }
                .padding(.bottom, 5)
                HStack {
                    Text("Défi : ")
                    Spacer()
                    BoutonSwitch(isOn: true)
                }.padding(5)
                HStack {
                    Text("Map :")
                    Spacer()
                    BoutonSwitch(isOn: false)
                }.padding(5)
                HStack {
                    Text("Type :")
                    Spacer()
                }
                .padding(5)
                HStack (spacing : 10) {
                    Spacer()
                    ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                        Image(theme.iconName)
                            .resizable()
                            .frame(width: 65, height: 65)
                            .shadow(color : .white, radius: 10)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    BoutonText(text: "OK", width: 40)
                    Spacer()
                }.padding(10)
            }
            .font(.custom("SpaceMono-Bold", size: 16))
            .foregroundColor(.white)
            .frame(width: 300, height: 433)
            .padding(.top, 105)

        }
    }
}

#Preview {
    SouvenirsFilterView()
}

struct LignePointilles: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.clear)
            .overlay(
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.white)
            )
            .padding(.horizontal)
            .padding(.top, 10)
    }
}

struct MonthPicker: View {
    
    @Binding var selectedMonth: Int
    @Binding var months: [String]
    
    var body: some View {
        Menu {
            ForEach(0..<months.count, id: \.self) { index in
                Button(action: {
                    selectedMonth = index + 1
                }) {
                    Text(months[index])
                }
            }
        } label: {
            Text(months[selectedMonth - 1])
                .foregroundColor(.white)
        }
    }
}

struct YearPicker: View {
    
    @Binding var selectedYear: Int
    @Binding var years: [Int]
    
    var body: some View {
        
        Menu {
            ForEach(years, id: \.self) { year in
                Button(action: {
                    selectedYear = year
                }) {
                    Text("\(year)")
                }
            }
        } label: {
            Text("\(selectedYear)")
                .foregroundColor(.white)
        }
    }
}
