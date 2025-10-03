//
//  SouvenirsViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 17/09/2025.
//

import SwiftUI
import Foundation
import Observation

@Observable

class SouvenirsViewModel {
    
    //MARK: - Data
    
    let souvenirsData : [Souvenir] = souvenirs
    
    func groupSouvenirsByMonth(_ souvenirs: [Souvenir]) -> [(key: String, value: [Souvenir])] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMMM yyyy"
        
        let grouped = Dictionary(grouping: souvenirs) { souvenir in
            formatter.string(from: souvenir.date)
        }
        return grouped.sorted { $0.key > $1.key }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    //MARK: - Filters
    
    var filters = SouvenirFilter()
    
    var filteredSouvenirs : [Souvenir] {
        
        souvenirsData.filter { souvenir in
            
            if let month = filters.month,
               Calendar.current.component(.month, from: souvenir.date) != month {
                return false
            }
            
            if let year = filters.year,
               Calendar.current.component(.year, from: souvenir.date) != year {
                return false
            }
            
            if filters.isDefi && souvenir.type != .mission  {
                return false
            }
            
            if filters.isMap && souvenir.type != .mapInsert  {
                return false
            }
            
            if !filters.theme.isEmpty && !filters.theme.contains(souvenir.theme) {
                return false
            }
            return true
        }
    }
    
    func dateEnString() -> String {
        
        let months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                             "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
        
        var result : [String] = []
        
        if let month = filters.month {
            result.append(months[month-1])
        }
        
        if let year = filters.year {
            result.append("\(year)")
        }
        return result.joined(separator : " ")
    }
    
    func resetFilters() {
        filters = SouvenirFilter()
    }
}
