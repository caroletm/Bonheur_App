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
    
    let souvenirsData = souvenirs
    
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
    
    
}
