//
//  MonthYearPicker.swift
//  Bonheur_App
//
//  Created by caroletm on 29/09/2025.
//

import SwiftUI

struct MonthYearPicker: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @State private var selectedMonth : Int?
    @State private var selectedYear : Int?
    
    @State var months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                         "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]

    @State var years = Array(2010...2030)
    
    var body: some View {
        HStack {
            MonthPicker(selectedMonth: $selectedMonth, months: $months)
                .environment(souvenirsViewModel)
            YearPicker(selectedYear: $selectedYear, years: $years)
                .environment(souvenirsViewModel)
        }
    }
}

struct MonthPicker: View {
    
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @Binding var selectedMonth: Int?
    @Binding var months: [String]
    
    var body: some View {
        Menu {
            ForEach(0..<months.count, id: \.self) { index in
                
                Button {
                    selectedMonth = index + 1
                    souvenirsViewModel.filters.month = selectedMonth
                    print(souvenirsViewModel.filters.month as Any)
                }label : {
                    Text(months[index])
                }
            }
        } label: {
            
            if selectedMonth != nil {
                Text(months[(selectedMonth ?? 1) - 1])
                    .foregroundColor(.white)
            } else {
                Text((months[(selectedMonth ?? 1) - 1]))
                    .foregroundStyle(.white)
                    .opacity(0.3)
            }
        }
    }
}

struct YearPicker: View {
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @Binding var selectedYear: Int?
    @Binding var years: [Int]
    
    var body: some View {
        
        Menu {
            ForEach(years, id: \.self) { year in
                
                Button {
                    selectedYear = year
                    souvenirsViewModel.filters.year = selectedYear
                    print(souvenirsViewModel.filters.year as Any)
                }label : {
                    Text("\(year)")
                }
            }
        } label: {
            
            if selectedYear != nil {
                Text("\(selectedYear ?? 2020)")
                    .foregroundColor(.white)
            } else {
                Text("\(selectedYear ?? 2020)")
                    .foregroundColor(.white)
                    .opacity(0.3)
            }
        }
    }
}


#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        MonthYearPicker()
    }
    .environment(SouvenirsViewModel())
}
