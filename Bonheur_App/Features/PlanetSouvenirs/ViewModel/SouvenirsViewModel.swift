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
    
    let souvenirsData : [any Souvenir] = souvenirs
    
    func groupSouvenirsByMonth(_ souvenirs: [any Souvenir]) -> [(key: String, value: [any Souvenir])] {
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
    
    var filteredSouvenirs : [any Souvenir] {
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
    
    func resetFilters() {
        filters = SouvenirFilter()
    }
    
}
