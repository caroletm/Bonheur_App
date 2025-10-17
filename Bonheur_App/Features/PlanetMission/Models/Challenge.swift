//
//  mission.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation

class Challenge : Identifiable, Hashable{
    
    
    var id = UUID()
    var challengeName : String
   
    
    init(challengeName: String) {
        
        self.challengeName = challengeName
        
    }
    // MARK: - Equatable
        static func == (lhs: Challenge, rhs: Challenge) -> Bool {
            return lhs.id == rhs.id
        }
        
        // MARK: - Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
}
