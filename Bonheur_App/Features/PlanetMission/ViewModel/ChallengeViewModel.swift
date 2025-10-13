//
//  MissionViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation
@Observable
    /// `ChallengeViewModel` est une classe observable utilisée pour gérer une liste de défis quotidiens.
    /// Elle fournit la logique nécessaire pour afficher le défi du jour, naviguer entre les défis,
    /// et suivre l’état actuel de la progression.
class ChallengeViewModel{
    // MARK: - Propriétés
    var challenges: [Challenge] = [
        Challenge(challengeName: "promene toi dans un parc en pleine ete a l'ombre", challengeDay: false),
        Challenge(challengeName: "boires deux litres D'eau", challengeDay: false),
        Challenge(challengeName: "Faire 10 pompes", challengeDay: false),
        Challenge(challengeName: "Lire 10 pages", challengeDay: true),
        Challenge(challengeName: "Marcher 5000 pas", challengeDay: false)
    ]
    var currentIndex : Int?
    var dayIndex : Int?
    
    // MARK: - Initialisation
        
        /// Initialise le `ViewModel` et sélectionne le défi du jour s’il existe.
        /// Sinon, sélectionne le premier défi de la liste.
    init(){
        if let index = challenges.firstIndex(where: {$0.challengeDay}){
            currentIndex = index
            dayIndex = index
        }else{
            currentIndex = 0
        }
    }
    // MARK: - Accès au défi courant
    
        /// Retourne le défi actuellement sélectionné.
        /// - Returns: Le `Challenge` correspondant à `currentIndex`, ou `nil` si aucun n’est défini.
    var currentChalenge : Challenge? {
        guard let index = currentIndex else {return nil}
        return challenges[index]
    }
    
    func ToggleChallenge(){
        if let dayIndex = dayIndex , currentIndex == dayIndex {
            var randomIndex: Int
            repeat{
                randomIndex = Int.random(in: 0..<challenges.count)
            } while randomIndex == dayIndex
            currentIndex = randomIndex
        } else if let dayIndex = dayIndex {
            
        }
    }
    
    
    
    
}
