//
//  mission.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation

class Challenge : Identifiable{
    var id = UUID()
    var challengeName : String
    var challengeDay : Bool
    
    init(challengeName: String, challengeDay: Bool) {
        
        self.challengeName = challengeName
        self.challengeDay = challengeDay
    }
    
}
