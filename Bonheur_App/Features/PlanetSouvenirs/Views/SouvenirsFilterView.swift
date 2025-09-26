//
//  SouvenirsFilterView.swift
//  Bonheur_App
//
//  Created by caroletm on 21/09/2025.
//

import SwiftUI

struct SouvenirsFilterView: View {
    
    @State private var selectedMonth : Int?
    @State private var selectedYear : Int?
    
    @State var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                         "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
    
    @State var years = Array(2010...2030)
    
    @State var isSelectedDefi : Bool = false
    @State var isSelectedMap : Bool = false
    @State var isSelectedTheme : Bool = false
    @State var selectedTheme : SouvenirTheme?
    
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
                    Button {
                        isSelectedDefi.toggle()
                    }label: {
                        if isSelectedDefi {
                            BoutonSwitch(isOn: true)
                        }else {
                            BoutonSwitch(isOn: false)
                        }
                    }
                }.padding(5)
                HStack {
                    Text("Map :")
                    Spacer()
                    Button {
                        isSelectedMap.toggle()
                    }label: {
                        if isSelectedMap {
                            BoutonSwitch(isOn: true)
                        }else {
                            BoutonSwitch(isOn: false)
                        }
                    }
                }.padding(5)
                HStack {
                    Text("Theme :")
                    Spacer()
                }
                .padding(5)
                HStack (spacing : 10) {
                    Spacer()
                    ForEach(SouvenirTheme.allCases, id: \.self) { theme in
                        
                        Button {
                            
                            isSelectedTheme.toggle()
                            
                            if isSelectedTheme {
                                selectedTheme = theme
                                
                            }else{
                                selectedTheme = nil
                            }
                            
                        }label: {
                            
                            if selectedTheme == theme {
                                Image(theme.iconName)
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .shadow(color : .white, radius: 10)
                            }else {
                                Image(theme.iconName)
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .opacity(0.3)
                            }
                        }
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    BoutonText(text: "OK", width: 45)
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
    SouvenirsFilterView(selectedTheme : nil)
}

//MARK: - Extracted Views

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
    
    @Binding var selectedMonth: Int?
    @Binding var months: [String]
    
    var body: some View {
        Menu {
            ForEach(0..<months.count, id: \.self) { index in
                Button(action: {selectedMonth = index + 1}) {
                    Text(months[index])
                }
            }
        } label: {
            Text(months[(selectedMonth ?? 1) - 1])
                .foregroundColor(.white)
        }
    }
}

struct YearPicker: View {
    
    @Binding var selectedYear: Int?
    @Binding var years: [Int]
    
    var body: some View {
        
        Menu {
            ForEach(years, id: \.self) { year in
                Button(action: {selectedYear = year})
                {
                    Text("\(year)")
                }
            }
        } label: {
            Text("\(selectedYear ?? 2020)")
                .foregroundColor(.white)
        }
    }
}
