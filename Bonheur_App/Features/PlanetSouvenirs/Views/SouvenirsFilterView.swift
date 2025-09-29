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
//    @State var isSelectedTheme : Bool = false
    @State var selectedTheme : [SouvenirTheme]
    
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
                            
                            if selectedTheme.contains(theme) {
                                selectedTheme.removeAll { $0 == theme}
                                
                            }else {
                                selectedTheme.append(theme)
                            }
                            print(selectedTheme)
                            
                        }label: {
                            
                            if selectedTheme.contains(theme) {
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
    SouvenirsFilterView(selectedTheme : [])
}


