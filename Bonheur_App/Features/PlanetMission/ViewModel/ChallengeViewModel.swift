//
//  MissionViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation
@Observable
class ChallengeViewModel{
    
    var challenges: [Challenge] = [
        Challenge(challengeName: "boires deux litres D'eau", challengeDay: false),
        Challenge(challengeName: "Faire 10 pompes", challengeDay: false),
        Challenge(challengeName: "Lire 10 pages", challengeDay: true),
        Challenge(challengeName: "Marcher 5000 pas", challengeDay: false)
    ]
    var currentIndex : Int? = nil
    var previousIndex : Int? = nil
    
    init(){
        if let dayIndex = challenges.firstIndex(where: {$0.challengeDay}){
            currentIndex = dayIndex
        }else{
            currentIndex = 0
        }
    }
    
    var currentChalenge : Challenge? {
        guard let index = currentIndex else {return nil}
        return challenges[index]
    }
    
    func nextChallenge() {
        guard let current = currentIndex else {return}
        let nextIndex = (current + 1) % challenges.count
        previousIndex = current
        currentIndex = nextIndex
    }
    
    
    
}
